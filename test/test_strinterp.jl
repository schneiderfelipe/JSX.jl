@testset "String interpolation" begin
    let name = "Brazil", continent = "south-america"
        @test htm"""
            <div>
                <span>$name</span>
                <span>$continent</span>
            </div>
        """ == JSX.Node(:div, [], [JSX.Node(:span, [], ["Brazil"]), JSX.Node(:span, [], ["south-america"])])

        # Using quotation marks
        @test htm"""
            <div id="$name" class="$continent" />
        """ == JSX.Node(:div, [:id => "Brazil", :class => "south-america"], [])
    end

    let imgtag = "img", imgattr = "src", imgurl = "https://julialang.org/assets/infra/logo.svg", alt = "The Julia Programming Language"
        img = htm"<$imgtag $imgattr=$imgurl alt=$alt />"
        @test img == JSX.Node(Symbol(imgtag), [Symbol(imgattr) => imgurl, :alt => alt], [])

        let atag = "a", aattr = "href", aurl = "https://julialang.org/", text = "The Julia Programming Language"
            # Great Scott!
            @test htm"<$atag $aattr=\"$aurl\">$text</$atag>" == JSX.Node(Symbol(atag), [Symbol(aattr) => aurl], [text])
            @test htm"<$atag $aattr=\"$aurl\">$text $img</$atag>" == JSX.Node(Symbol(atag), [Symbol(aattr) => aurl], [text, img])
        end
    end
end