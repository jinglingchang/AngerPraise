Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
    namespace :v1 do
      # Directs /admin/products/* to Admin::ProductsController
      # (app/controllers/admin/products_controller.rb)



      get 'home/test'

      get 'home/index'

      get 'home/indexs'

      get 'home/friend'

      get 'home/hr_interview'

      get 'home/dynamic'

      get 'user/login'=>'user#login'

      get 'user/register'=>'user#register'

      get 'user/info'=>'user#info'

      get 'user/integral'

      get 'user/user_position_number'

      get 'user/resume_url'=>'user#resume_url'

      get 'user/mission'

      get 'user/pay_url'

      get 'user/user_apply_url'

      get 'user/user_friend_url'

      get 'user/user_hr_url'

      get 'user/apply_password_check'

      get 'user/forget_password_check'

      get 'about/setting'

      post 'user/update_photo'=>'user#update_photo'

      get 'user/update_nickname'=>'user#update_nickname'

      get 'user/update_password'

      get 'user/forget_update_password'

      get 'user/position_collect'=>'user#position_collect'

      get 'user/user_position_apply_list'

      get 'user/resume'=>'user#get_resume'

      get 'user/resume_perfect'=>'user#perfectUserResume'

      get 'user/get_password'=>'user#get_initial_password'

      get 'user/check_password'=>'user#check_password'

      get 'user/get_friend'

      get 'user/phone_book'=>'user#getUserPhoneBook'

      get 'user/user_inactive'

      get 'user/logout'

      get 'user/backlist'

      get 'user/code'

      get 'user/device'

      get 'industry/industry_info'=>'industry#getIndustryMain'

      get 'position/recommended'=>'position#recommended_position'

      get 'position/detail'

      get 'position/user_recommend_tag'=>'position#user_recommend_tag'

      get 'position/apply'

      get 'position/apply_list'=>'position#apply_list'

      get 'position/apply_all'=>'position#apply_all_record'

      get 'position/senior_search'

      get 'company/detail'=>'company#detail'

      get 'company/collect'=>'company#collect'

      get 'company/get_position_list'

      post 'resume/collect'=>'resume#collect'

      post 'resume/create'=>'resume#create'

      get 'weixin/share'=>'weixin#share'


      get 'user/get_resume_perview_url'

      get 'user/get_resume_perfect_url'




    end


  get 'token'=>'token#index'

  get 'api_test'=>'api_test#index'
end
