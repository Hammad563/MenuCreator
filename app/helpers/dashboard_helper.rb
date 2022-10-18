module DashboardHelper
    def dashboard_header_class(controller)
        default_class = "inline-flex items-center px-1 pt-1 border-b-2 text-sm font-medium"
        active_class = "border-blue-500 text-gray-900"
        inactive_class = "border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700 "
        if controller_name == controller
            active_class + default_class
        else
            inactive_class + default_class
        end
    end
    def dashboard_mobile_class(controller)
        default_class = "block pl-3 pr-4 py-2 border-l-4 text-base font-medium"
        active_class = "bg-green-50 border-blue-500 text-green-700 "
        inactive_class = "border-transparent text-gray-500 hover:bg-gray-50 hover:border-gray-300 hover:text-gray-700 "
    
        if controller_name == controller
          active_class + default_class
        else
          inactive_class + default_class
        end
    end
end
