class AdminController < ActionController::Base
  def index
    @all_applications = PetsApplication.all
  end
  def shelters_index
    @shelters = Shelter.order_by_name_alphabetical
    @pending_apps = Shelter.with_pending_applications
  end

  def show
    @application = PetsApplication.find(params[:id])
    @applicant = Applicant.find(@application.applicant_id)
    @pets = Pet.pets_with_app_status_by_sql(@application)
    @status = PetsApplication.check_app_status(@applicant)
  end

  def approve_reject
    @application = PetsApplication.find_application(params[:pet_id], params[:applicant_id])
    @application.first.update(status: params[:status])
    @applicant = Applicant.find(params[:applicant_id])
    @status = PetsApplication.check_app_status(@applicant)
    redirect_to "/admin/pets_applications/#{@application.first.id}"
  end
end