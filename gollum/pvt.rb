class Gollum::Filter::Pvt < Gollum::Filter

    def extract(data)
        # substitute contents of @start/endvalid with inside value
        # and return substitued data (copy)
        data.gsub(/@startvalid\r?\n(.+?)\r?\n@endvalid\r?$/m) do
            $1
        end
        # this will be rendered in html by last Filter::extract
    end

    def process(data)
         data
    end

end
