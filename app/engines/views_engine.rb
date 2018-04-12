class ViewsEngine < ApplicationEngine
  ThemeBoooyaDefault = "<!DOCTYPE html>
    <html lang=\"en\">
      <head>
        <title><%= @project.name %></title>
        <%= csrf_meta_tags %>
        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
        <meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">
        <%= stylesheet_link_tag \"boooya\", media: \"all\", \"data-turbolinks-track\": \"reload\" %>
      </head>
      <body>
        <div class=\"app\">
          <div class=\"app-container\">
            <div class=\"app-sidebar app-navigation app-navigation-fixed scroll app-navigation-style-default app-navigation-open-hover dir-left\" data-type=\"close-other\">
              <a href=\"#\" class=\"app-navigation-logo\"><%= @project.name %></a>
              <nav>
                
              </nav>
            </div>
            <div class=\"app-content app-sidebar-left\">
              <div class=\"app-header app-header-design-default\">
                <ul class=\"app-header-buttons\">
                  <li class=\"visible-mobile\"><a href=\"#\" class=\"btn btn-link btn-icon\" data-sidebar-toggle=\".app-sidebar.dir-left\"><span class=\"icon-menu\"></span></a></li>
                  <li class=\"hidden-mobile\"><a href=\"#\" class=\"btn btn-link btn-icon\" data-sidebar-minimize=\".app-sidebar.dir-left\"><span class=\"icon-menu\"></span></a></li>
                </ul>
                <form class=\"app-header-search\" action=\"\" method=\"post\"><input type=\"text\" name=\"keyword\" placeholder=\"Search\"></form>
                <ul class=\"app-header-buttons pull-right\">
                  <li>
                    <div class=\"contact contact-rounded contact-bordered contact-lg contact-ps-controls hidden-xs\">
                      <%= image_tag 'logo-icon.png' %>
                      <div class=\"contact-container\"><a href=\"javascript:;\">Current</a> <span><%= @current_project.code %></span></div>
                      <div class=\"contact-controls\">
                        <div class=\"dropdown\">
                          <button type=\"button\" class=\"btn btn-default btn-icon\" data-toggle=\"dropdown\"><span class=\"icon-cog\"></span></button>
                          <ul class=\"dropdown-menu dropdown-left\">
                            <li><a href=\"pages-profile-social.html\"><span class=\"icon-users2\"></span> Account</a></li>
                            <li><a href=\"pages-messages-chat.html\"><span class=\"icon-envelope\"></span> Messages</a></li>
                            <li><a href=\"pages-profile-card.html\"><span class=\"icon-users2\"></span> Contacts</a></li>
                            <li class=\"divider\"></li>
                            <li><a href=\"pages-email-inbox.html\"><span class=\"icon-envelope\"></span> E-mail <span class=\"label label-danger pull-right\">19/2,399</span></a></li>
                          </ul>
                        </div>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class=\"dropdown\">
                      <button class=\"btn btn-default btn-icon btn-informer\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"true\"><span class=\"icon-alarm\"></span><span class=\"informer informer-danger informer-sm informer-square\">+3</span></button>
                      <ul class=\"dropdown-menu dropdown-form dropdown-left dropdown-form-wide\">
                        <li class=\"padding-0\">
                          <div class=\"app-heading title-only app-heading-bordered-bottom\">
                            <div class=\"icon\"><span class=\"icon-text-align-left\"></span></div>
                            <div class=\"title\">
                              <h2>Notifications</h2>
                            </div>
                            <div class=\"heading-elements\"><a href=\"#\" class=\"btn btn-default btn-icon\"><span class=\"icon-sync\"></span></a></div>
                          </div>
                          <div class=\"app-timeline scroll app-timeline-simple text-sm\" style=\"height: 240px\">
                            <div class=\"app-timeline-item\">
                              <div class=\"dot dot-primary\"></div>
                              <div class=\"content\">
                                <div class=\"title margin-bottom-0\"><a href=\"#\">Jessie Franklin</a> uploaded new file <strong>844_jswork.pdf</strong></div>
                              </div>
                            </div>
                            <div class=\"app-timeline-item\">
                              <div class=\"dot dot-warning\"></div>
                              <div class=\"content\">
                                <div class=\"title margin-bottom-0\"><a href=\"#\">Taylor Watson</a> changed work status <strong>PSD Dashboard</strong></div>
                              </div>
                            </div>
                            <div class=\"app-timeline-item\">
                              <div class=\"dot dot-success\"></div>
                              <div class=\"content\">
                                <div class=\"title margin-bottom-0\"><a href=\"#\">Dmitry Ivaniuk</a> approved project <strong>Boooya</strong></div>
                              </div>
                            </div>
                            <div class=\"app-timeline-item\">
                              <div class=\"dot dot-success\"></div>
                              <div class=\"content\">
                                <div class=\"title margin-bottom-0\"><a href=\"#\">Boris Shaw</a> finished work on <strong>Boooya</strong></div>
                              </div>
                            </div>
                            <div class=\"app-timeline-item\">
                              <div class=\"dot dot-danger\"></div>
                              <div class=\"content\">
                                <div class=\"title margin-bottom-0\"><a href=\"#\">Jasmine Voyer</a> declined order <strong>Project 155</strong></div>
                              </div>
                            </div>
                          </div>
                        </li>
                        <li class=\"padding-top-0\"><button class=\"btn btn-block btn-link\">Preview All</button></li>
                      </ul>
                    </div>
                  </li>
                  <li><%= link_to raw('<span class=\"icon-power-switch\"></span>'), sign_out_path, data: { confirm: 'Are you sure?' }, class: 'btn btn-default btn-icon' %></li>
                </ul>
              </div>
              <%= yield %>
            </div>
          </div>
          <div class=\"app-footer app-footer-default\" id=\"footer\">
            <div class=\"app-footer-line\">
              <div class=\"copyright wide text-center\"><%= @project.copyright %></div>
            </div>
          </div>
          <div class=\"app-overlay\"></div>
        </div>
        <%= javascript_include_tag \"boooya\" %>
        <%= content_for :javascript %>
      </body>
    </html>"

  def compile
    @project.namespaces.each do |namespace|
      @project.source_codes.create!(prefix: ["app", "views", "layouts"],
        file_name: "#{namespace.module}",
        extension: "html.erb",
        content: layout)
      namespace.resourceful_controllers.each do |resourceful_controller|
        ["app", "views", namespace.module, resourceful_controller.model.name.pluralize].tap do |prefix|
          resourceful_controller.retrieve_collections.each do |retrieve_collection|
            @project.source_codes.create!(prefix: prefix,
              file_name: "#{retrieve_collection.action_code}",
              extension: "html.erb",
              content: retrieve_collection_code_for(retrieve_collection))
          end
          if resourceful_controller.retrieve_element.present?
            @project.source_codes.create!(prefix: prefix,
              file_name: "show",
              extension: "html.erb",
              content: retrieve_element_code_for(resourceful_controller.retrieve_element))
          end
          if resourceful_controller.individual_creation.present?
            @project.source_codes.create!(prefix: prefix,
              file_name: "new",
              extension: "html.erb",
              content: individual_creation_code_for(resourceful_controller.individual_creation))
          end
          if resourceful_controller.individual_updation.present?
            @project.source_codes.create!(prefix: prefix,
              file_name: "edit",
              extension: "html.erb",
              content: individual_updation_code_for(resourceful_controller.individual_updation))
          end
        end
      end
    end
  end

  protected
    def layout
      "abc"
    end

    def retrieve_collection_code_for retrieve_collection
      [].tap do |result|
        result << "abc"
      end
    end

    def retrieve_element_code_for retrieve_element
      [].tap do |result|
        result << "abc"
      end
    end

    def individual_creation_code_for individual_creation
      [].tap do |result|
        result << "abc"
      end
    end

    def individual_updation_code_for individual_updation
      [].tap do |result|
        result << "abc"
      end
    end
end
