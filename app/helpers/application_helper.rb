module ApplicationHelper
  # type: css | js
  def vite_include_tag type, *assets
    asset_path = if Rails.env.development?
      "//#{request.host}:#{3036}/src/packs"
    else
      "//#{request.host_with_port}"
    end

    # asset_path = "http://localhost:5009"
    if Rails.env.development?
      if type == "css"
        return nil
      end
    end

    links = []
    assets.each do |a|
      asset_url = "#{asset_path}/#{a}.jsx"

      if Rails.env.production?
        file = "src/packs/" + a + ".jsx"
        if AssetsManifest.has_key?(file)
          if type == "css"
            unless AssetsManifest[file]["css"].blank?
              AssetsManifest[file]["css"].each do |css|
                links << %Q{<link rel="stylesheet" href="#{asset_path}/#{css}">}
              end
            end
          else
            asset_url = "#{asset_path}/#{AssetsManifest[file]["file"]}"
            links << %Q{<script type="module" src="#{asset_url}"></script>}
          end
        end
      else
        links << %Q{<script type="module" src="#{asset_url}"></script>}
      end
    end
    links.flatten.join.html_safe
  end
end
