module ApplicationHelper

    def get_gravatar(user, options = {size: 80})
        # using gravatar to display image for user if email is associated with gravatar account
        # https://en.gravatar.com/site/implement/images/ruby/
        # get the email from URL-parameters or what have you and make lowercase
        email_address = user.email
        
        # create the md5 hash
        hash = Digest::MD5.hexdigest(email_address)

        size = options[:size]
        
        # compile URL which can be used in <img src="RIGHT_HERE"...
        gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"

        image_tag(gravatar_url, alt: 'No Image available for this User!', class: 'rounded shadow mx-auto d-block')
    end

end
