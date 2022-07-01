xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title "RightScale Releases"
  xml.subtitle "Keep up to date with RightScale Releases"
  xml.id "https://docs.rightscale.com"
  xml.link "href" => "https://docs.rightscale.com/release-notes"
  xml.link "href" => "https://docs.rightscale.com/release-notes", "rel" => "self"
  xml.updated (blog('release-notes').articles.first.date.to_time.iso8601)
  xml.author { xml.name "RightScale" }

blog('release-notes').articles[0...5].each do |article|
  xml.entry do
    xml.title article.title
    xml.link "rel" => "alternate", "href" => article.url
    xml.id "https://docs.rightscale.com/release-notes"
    xml.author { xml.name "RightScale" }
    end
  end
end
