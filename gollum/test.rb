class Gollum::Filter::ReqTest < Gollum::Filter

    def extract(data)
        data.gsub(/@starttest\r?\n(.+?)\r?\n@endtest\r?$/m) do
            id       = Digest::SHA1.hexdigest($1)
            @map[id] = { :req => $1 }
            id
        end
    end

    def process(data)
        @map.each do |id, spec|
            data.gsub!(id) do
                render_test(id, spec[:req])
            end
        end
        data
    end

    def plang(req)
        res = {}
        current=nil
        req.lines do |line|
            l = line.chomp
            if m = l.match(/([A-Z]+)\s?:\s?(.*)/)
                current = m[1]
                res[current] = m[2]
            else
                if current!=nil
                    res[current] = res[current]+"\n"+l
                end
            end
        end
        res
    end

    def anchor_name(name)
        name.gsub!(/[^\d\w\u00C0-\u1FFF\u2C00-\uD7FF]/, "-")
        name.gsub!(/-+/, "-")
        name.gsub!(/^-/, "")
        name.gsub!(/-$/, "")
        name.downcase!
    end

    def render_cover(cover)
        res = ""
        cover.gsub(/\S+/m) do |e|
            name = e.dup
            ref = "/doc/hlr##{anchor_name(e)}"
            res = res+"<div><a href=\"#{ref}\">#{name}</a></div>\n"
        end
        res
    end

    def render_test(id, req)
        yreq = plang(req)
        ref = yreq['REF']
        anchor = anchor_name(ref.dup)
        desc = yreq['DESC']
        means = render_cover(yreq['MEANS'])
        precond = yreq['PRECOND']
        cover = render_cover(yreq['COVER'])
        summary = yreq['SUMMARY']
        text = GitHub::Markup.render(@markup.name, yreq['TEST'])
        "
<div id=\"#{anchor}\" class=\"requirement_test\">
<table style=\"width:100%;display: table;\">
  <tbody>
    <tr>
      <td style=\"width:200px;\">Reference</td>
      <td><strong>#{ref}</strong></td>
    </tr>
    <tr>
      <td>Short description</td>
      <td><strong>#{desc}</strong></td>
    </tr>
    <tr>
      <td>Test means</td>
      <td> <strong>#{means}</strong> </td>
    </tr>
    <tr>
      <td>Pre-conditions</td>
      <td><strong>#{precond}</strong></td>
    </tr>
    <tr>
       <td>Cover list</td>
      <td>#{cover}</td>
    </tr>
  </tbody>
</table>
<p>#{summary}</p>
<p>#{text}</p>
<hr></hr>
<p>&nbsp;</p>
</div>"
#      html_error("Sorry, unable to render Requirement at this time")
    end

end
