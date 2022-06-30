# Setting 301 Redirects on Objects in the support.rightscale.com S3 bucket

1. Edit the `set-s3-redirects.rb` file with the AWS Secret Access Key (get it from Ali or Christian) and add your old/new URLs
2. Run `ruby set-s3-redirects.rb`

It may take up to 24 hours for new redirects to propagate through AWS CloudFront
