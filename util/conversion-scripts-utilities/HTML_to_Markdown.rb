################################################################################
#Convert a series of files from HTML to Markdown
#Input: HTML File or a Folder that contains a tree with HTML files
#Output: Folder generated for each HTML folder detected containing a .html.md
#         file with the converted markdown code as well as a .png file for each
#         image found in the html code
#     A Log file is created containing the success of each html file conversion.
#     Any errors in locating files are displayed at the top of the log file
#Assumptions: each html file must be called "index.html"
#             BaseURL contains the path to site repository on this machine
################################################################################



require 'reverse_markdown'
require 'Nokogiri'
require 'FileUtils'



def MarkdownConversion(htmlFile, output_direct)


  #Key terms used for parsing HTML file
  startContent = '<span class="title">'
  endContent = "<!-- END Page Content -->"
  startComment = "<!-- START Comments -->"
  endComment = "<!-- END Comments -->"
  startAttachment = "<!-- START File attachments -->"
  endAttachment = "<!-- END File attachments -->"
  startToC = "<h5>Table of Contents</h5>"
  endToC = '<div id="pageText">'
  imageTag = "src="
  # Modify the next line to point to a copy of the old site repository on your machine
  baseURL = 
  mainbody = false
  titleLine = ''
  cutFile = ''
  imageLines = Array.new
  images = Array.new
  imageNames = Array.new



  #loop through the given file line by line
  IO.foreach(htmlFile) do |line|

      #remove whitespace before and after text
      check = line.strip

      #Isolate main body
      if check.include? startContent
        titleLine = line #identify title
        mainbody = true
      end

      if check == endContent
        mainbody = false
      end

      #Remove comment section
      if check.include? startComment
        mainbody = false
      end

      if check.include? endComment
        mainbody = true
      end

      #Remove attachment section
      if check.include? startAttachment
        mainbody = false
      end

      if check.include? endAttachment
        mainbody = true
      end

      #Remove table of contents
      if check.include? startToC
        mainbody = false
      end

      if check.include? endToC
        mainbody = true
      end

      #Locate each line that contains an image tag
      if check.include? imageTag
        imageLines << check
      end

      #Combine all desired lines
      if mainbody == true
        cutFile += line
      end

  end #end line foreach


  #Format Title
  titleLine.slice! startContent
  titleLine.slice! "</span>"
  titleLine.strip!

  #loop through each line that contains an image url
  imageLines.each {|imageLine|

    #initialize image index location
    imgStartindex = 0
    imgEndindex = 0
    imageURL = "" #initialize image url string
    strLength = imageLine.length #determine the length of the string

      for i in 0...strLength #iterate strLength number of times
        if imageLine[i] == "s" && imageLine[i + 1] == "r" && imageLine[i + 2] == "c" && imageLine[i + 3] == "="
          #i = location of "s" in "src"
          imgStartindex = i + 5
        end

        if imageLine.include? ".png" # if image is a png

          if imageLine[i] == "." && imageLine[i + 1] == "p" && imageLine[i + 2] == "n" && imageLine[i + 3] == "g"
            #i = location of "." in ".png"
            imgEndindex = i + 4
          end

        elsif imageLine.include? ".jpg" #if image is a jpg

          if imageLine[i] == "." && imageLine[i + 1] == "j" && imageLine[i + 2] == "p" && imageLine[i + 3] == "g"
            #i = location of "." in ".png"
            imgEndindex = i + 4
          end

        elsif imageLine.include? ".gif" #if image is a gif

          if imageLine[i] == "." && imageLine[i + 1] == "g" && imageLine[i + 2] == "i" && imageLine[i + 3] == "f"
            #i = location of "." in ".png"
            imgEndindex = i + 4
          end

        else #image is not in a recognizable format

          imgStartindex = 0
          imgEndindex = 0

        end

      end #end for loop

      #generate image url using given index
      for j in imgStartindex...imgEndindex
        imageURL += imageLine[j]
      end

      #puts "Adding the url #{imageURL} to the images array for the file #{titleLine}"
      unless imageURL == ""
        images << imageURL
      end
  } #end Array foreach loop



  #remove ending tags
  cutFile.slice! endAttachment
  cutFile.slice! endComment
  cutFile.slice! titleLine


  #Generate Front Matter
  frontMatter = "---\n\rtitle: #{titleLine}\n\r---\n\r"
  titleLine.tr!(" ", "_")



  #Nokogiri convert remaining file contents
  doc = Nokogiri::HTML(cutFile)

  #Perform Markdown conversion
  markConvert = ReverseMarkdown.convert doc

  #Combine converted page with front matter
  markPage = frontMatter + markConvert



  #modify lines in markdown code with images in them to contain image names rather than image urls
 #Determine which lines in the markdown code contain images
 newMark = ""
 markPage.each_line do |markLine|

    if markLine.include? "![" #![ identifies an image in markdown code

      #initializations required to modify image lines
      listPNG = Array.new
      listSlash = Array.new
      endParenth = Array.new
      newMarkLine = ""

      reverseMark = markLine.reverse
      markLength = markLine.length
      for m in 0..markLength

        #Locate any area in the line in which ".png", ".jpg", and ".gif" are present
        if reverseMark[m] == "g" && reverseMark[m + 1] == "n" && reverseMark[m + 2] == "p" && reverseMark[m + 3] == "."
          listPNG << m
        end

        if reverseMark[m] == "g" && reverseMark[m + 1] == "p" && reverseMark[m + 2] == "j" && reverseMark[m + 3] == "."
          listPNG << m
        end

        if reverseMark[m] == "f" && reverseMark[m + 1] == "i" && reverseMark[m + 2] == "g" && reverseMark[m + 3] == "."
          listPNG << m
        end

        #Locate all slashes in the image line
        if reverseMark[m] == "/"
          listSlash << m
        end

        #locate all end parentheses in the image line
        if reverseMark[m] == ")"
          endParenth << m
        end

      end #end for m

      firstSlash = markLength - listSlash.at(listSlash.count - 1) - 1
      finalSlash = markLength - listSlash.at(0)
      unless listPNG.count == 0
      lastPNG = markLength - listPNG.at(0)
      lastParenth = markLength - endParenth.at(0) -1


      #Generate new image line using the found indices
      for a in 0...firstSlash
        newMarkLine += markLine[a]
      end

      for b in finalSlash...lastPNG
        newMarkLine += markLine[b]
      end


      for c in lastParenth...markLength
        newMarkLine += markLine[c]
      end

      newMark += newMarkLine
    end #end unless png array is empty
    else
      newMark += markLine

    end #end if include "!["
 end #end markPage foreach



#Remove any instance of consecutive blank lines in markdown code
consecBlank = 0
noBlank = ""
newMark.each_line do |blank|
  removeBlank = blank.strip
  if removeBlank == ""
    consecBlank += 1
  else
    consecBlank = 0
  end

  if consecBlank == 2
    consecBlank = 0
  else
    noBlank += blank
  end

end #end newMark foreach




  Dir.chdir(output_direct) #Move into the output directory

  #Create a file and export Markdown conversion
  filename = titleLine + ".html.md" #Generate file name using .html.md extension
  filepath = Dir.pwd #Obtain current directory
  filepath += "/" #Append "/" to current directory

  outFolder = filepath + titleLine

  unless titleLine.include? "/" #Remove instances in which file structure causes a slash to exist inside the file name
  puts "Creating directory for #{titleLine}"
  Dir.mkdir(outFolder) #Make the folder for this HTML file
  Dir.chdir(outFolder) #Move into the created folder

  puts "Creating .html.md File for #{titleLine}"

  currentPath = filepath + filename #Append filename to current path

  File.new filename, "w" #Create file using generated file name

  writeDirec = outFolder + "/" + filename

  File.write(writeDirec, noBlank) #Populate generated file with markdown code



  puts "Creating Image files for #{titleLine}"

  #loop through each image url found
  images.each { |img|

    imgDirect = baseURL + img #append image url to base url

    #Create a version of this directory without the filename
    imgSlashes = Array.new
    checkimg = ""
    reverseimg = imgDirect.reverse
    imglength = imgDirect.length
    for sl in 0..imglength
      if reverseimg[sl] == "/"
        imgSlashes << sl
      end
    end

    lastimgSlash = imglength - imgSlashes.at(0) - 1

    for nimg in 0..lastimgSlash - 1
      checkimg += imgDirect[nimg]
    end

    if Dir.exists? checkimg #Eliminate cases in which a faulty URL is retrieved
    urlLength = imgDirect.length #Determine the length of the url
    reverseURL = imgDirect.reverse #create a reversed copy of the url
    slashIndex = Array.new #create an index of slash indices

    #loop through the reversed copy and store the index of each slash
    for char in 0...urlLength
      if reverseURL[char] == "/"
        slashIndex << char
      end
    end

    lastSlash = urlLength - slashIndex.at(0) - 1 #determine the index of the final slash
    shortURL = "" #create shorter version of the URL
    for slash in 0...lastSlash
      shortURL += imgDirect[slash]
    end

    #move all files in the directory one behind that found in the html file into the output folder
    Dir.foreach(shortURL) do |imgFile|
      unless imgFile == "." || imgFile == ".." || imgFile == ".DS_Store"
        imgExport = shortURL + "/" + imgFile
        FileUtils.cp_r(Dir[imgExport], outFolder) #Move the image file into the output folder
      end
    end #end shortURL foreach


    Dir.foreach(outFolder) do |exported|

      expDirect = outFolder + "/" + exported

      #remove hidden "opensearch" file
      if exported == "opensearch"
        FileUtils.rm_rf(expDirect)
      end

      #Remove excess content in png URLs
      if exported.include? ".png"
        expLength = exported.length

        for x in 0...expLength
          if exported[x] == "." && exported[x + 1] == "p" && exported[x + 2] == "n" && exported[x + 3] == "g"
            gloc = x + 4
          end
        end

        if expLength > gloc
          newURL = ""
          for c in 0...gloc
            newURL += exported[c]
          end

          newExpDirect = outFolder + "/" + newURL
          FileUtils.mv expDirect, newExpDirect
        end #end if expLength > gloc

      #Remove excess content in jpg URLs
      elsif exported.include? ".jpg"
        expLength = exported.length

        for x in 0...expLength
          if exported[x] == "." && exported[x + 1] == "j" && exported[x + 2] == "p" && exported[x + 3] == "g"
            gloc = x + 4
          end
        end

        if expLength > gloc
          newURL = ""
          for c in 0...gloc
            newURL += exported[c]
          end

          newExpDirect = outFolder + "/" + newURL
          FileUtils.mv expDirect, newExpDirect
        end #end if expLength > gloc


      #Remove excess content in gif URLs
      elsif exported.include? ".gif"
        expLength = exported.length

        for x in 0...expLength
          if exported[x] == "." && exported[x + 1] == "g" && exported[x + 2] == "i" && exported[x + 3] == "f"
            gloc = x + 4
          end
        end

        if expLength > gloc
          newURL = ""
          for c in 0...gloc
            newURL += exported[c]
          end
          imageNames << newURL
          newExpDirect = outFolder + "/" + newURL
          FileUtils.mv expDirect, newExpDirect
        end #end if expLength > gloc


      end #end if include png

    end #end outfolder foreach
    logtext = "File: #{titleLine}:\n\r- Looking for the file: #{imgDirect}\n\r-File found\n\r\n\r"
    $imgNoError << logtext
  else
    puts "Faulty URL detected"
    logtext = logtext = "File: #{titleLine}:\n\r- Looking for the file: #{imgDirect}\n\r-ERROR: File not found\n\r"
    $imgError << logtext

  end #end if directory exists

  } #end image url for each loop

  puts ""


end #end unless

end  #end method


###############################################################################


def TreeParse(inBranch, outBranch)
  Dir.chdir(outBranch) #Move into the next level of the output folder
  Dir.foreach(inBranch) do |branch| #Loop through each object in the input folder
    unless branch == "." || branch == ".." || branch == ".DS_Store" #Ignore hidden folders
    inPath = inBranch + "/" + branch
    #When a folder is found in the input, an identically named folder is created in the output
    if File.directory? (inPath)
      outPath = outBranch + "/" + branch
      Dir.mkdir(outPath)
      TreeParse(inPath, outPath) #The method is recursively called using the new level of the output folder

      #Whena  file is found, it is converted to markdown
    elsif File.file? (inPath)

      #Remove all content from the file name after the final "/"
      indexFile = ""
      pathSlashes = Array.new
      pathSize = inPath.length
      reversePath = inPath.reverse

      for s in 0..pathSize
        if reversePath[s] == "/"
          pathSlashes << s
        end
      end

      lastPathSlash = pathSize - pathSlashes.at(0)

      for ind in lastPathSlash..pathSize - 1
        indexFile += inPath[ind]
      end

      #All files not called "index.html" are ignored
      if indexFile == "index.html"
        MarkdownConversion(inPath, outBranch) #Convert the html file to markdown
      end

    else
    end #end if
    end #end unless
  end #end foreach
end #end method


###############################################################################


#Verify correct amount of input was received
if ARGV.size != 2
  abort "Please introduce input directory followed by an output directory"
end
in_direct = ARGV[0]
out_direct = ARGV[1]

#store current directory
initialdirect = Dir.pwd


Dir.chdir(out_direct) #move into the top level of the output folder
puts "Generating Log File"
puts ""
File.new "Log.txt", "w" #Create the Log.txt file
#Create arrays necessary for tracking faulty img urls
$imgError = Array.new
$imgNoError = Array.new
logDirect = out_direct + "/" + "Log.txt"
TreeParse(in_direct, out_direct) #Call main recursive method using the given input/output directories
puts "Updating Log File"
puts ""
#Display all error messages in the log
$imgError.each { |error|
  File.open(logDirect, 'a') do |elog|
    elog.puts error
  end
}
#Display all success messages in the log
$imgNoError.each { |noError|
  File.open(logDirect, 'a') do |nlog|
    nlog.puts noError
  end
  }


Dir.chdir(initialdirect) #Return to the initial directory
