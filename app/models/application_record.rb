class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true



























def query_google( email )
        self.refresh_token_from_google if self.expires_at.to_i < Time.now.to_i

        @google_api_client = Google::APIClient.new(
          application_name: 'Joggle',
          application_version: '1.0.0'
        )

        @google_api_client.authorization.access_token = self.access_key
        @gmail = @google_api_client.discovered_api('gmail', "v1")


        # https://developers.google.com/gmail/api/v1/reference/users/messages/list
        # Now that we instantiated gmail, we can take the category (messages) and the method
        # You can also add parameters if you wish to do so:
        # @calendar_events = google_api_client.execute(
        #     :api_method => @calendar.events.list,
        #     :parameters => {
        #         "calendarId" => current_user.email,
        #         'timeMin' => date.to_s,
        #         'timeMax' => max_date.to_s
        #         # 'items' => [{'id' => current_user.email}]
        #     },
        #     :headers => {'Content-Type' => 'application/json'}
        # )
        @emails = @google_api_client.execute(
            api_method: @gmail.users.messages.list,
            parameters: {
                userId: "me",

                # searching messages based on number of queries:
                # https://developers.google.com/gmail/api/guides/filtering
                q: "from:" + email.to_s
            },
            headers: {'Content-Type' => 'application/json'}
        )


        count = @emails.data.messages.count
        Rails.logger.error count 
        {count: count, last_emails: get_three_emails} if count > 0


end
