class Gollum::Filter::Amalgamation < Gollum::Filter

    def extract(data)
        data
    end

    def process(data)
        breadcrumb() + toc() + data
    end
    
    def toc()
        path = @markup.page.url_path()
        dirs = path.split("/")
        dirs.slice!(-1)
	dirs.insert(0,@markup.wiki.path)
        filepath = dirs.join("/")+"/amalgamation.textile"
        if (File.file?(filepath))
            amalgamation = GitHub::Markup.render(@markup.name, File.read(filepath))
            "<div class=\"amalgamation\">#{amalgamation}</div>\n"
        else
            ""
        end
    end

    def breadcrumb()
        path = @markup.page.url_path()
        as = path.split("/")
        as.slice!(0)
        as.slice!(-1)
        href="amalgamation"
        as = as.reverse.map do |x|
            a = "<a href=\"#{href}\">#{x}</a>/"
            href = "../"+href
            a
        end
        "<div class=\"breadcrumb\">#{as.reverse.join}</div>\n"
    end
end
