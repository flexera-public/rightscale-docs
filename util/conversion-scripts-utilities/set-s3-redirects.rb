require 'aws-sdk'

s3 = Aws::S3::Client.new(region:'us-west-1', credentials: Aws::Credentials.new(
  'YOUR_ACCESS_KEY_ID', 'YOUR_SECRET_ACCESS_KEY')) #GET THIS FROM ALI OR CHRISTIAN
redirects = [
  # [OLD_URL, NEW_URL], e.g.:
  # ['http://support.rightscale.com/12-Guides/RightScale_API_1.5/index.html', 'https://docs.rightscale.com/api/api_1.5_examples/index.html'],
]
redirects.each do |redirect|
  s3.copy_object(
    bucket: 'support.rightscale.com',
    copy_source: redirect[0].sub('http://',''),
    key: redirect[0][30..-1],
    acl: 'public-read',
    website_redirect_location: redirect[1])
end
puts 'Done!'
