require "rails_helper"

RSpec.describe "the pets_applications index" do
  it "shows a list of shelters in reverse alphabetical order" do
    shelter = Shelter.create(name: "Boulder shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    shelter_3 = Shelter.create(name: "Golder shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Bare-y Manilow", shelter_id: "#{shelter.id}")
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: "#{shelter.id}")
    pet_3 = Pet.create(adoptable: true, age: 1, breed: "domestic shorthair", name: "Sylvester", shelter_id: "#{shelter_2.id}")
    pet_4 = Pet.create(adoptable: true, age: 1, breed: "orange tabby shorthair", name: "Lasagna", shelter_id: "#{shelter_2.id}")

    applicant_1 = Applicant.create(name: "George", street_address: "1421 W Mockingbird Ln", city: "Boulder", state: "Texas", zip_code: "23452", description: "I love animals!")
    
    app_1 = PetsApplication.create!(applicant: applicant_1, pet: pet_1 )
    app_2 = PetsApplication.create!(applicant: applicant_1, pet: pet_2 )
    app_3 = PetsApplication.create!(applicant: applicant_1, pet: pet_3 )
    app_4 = PetsApplication.create!(applicant: applicant_1, pet: pet_4 )

    visit "/admin/pets_applications"

    expect(page).to have_content("Application #{app_1.id}")
    expect(page).to have_content("Application #{app_2.id}")
    expect(page).to have_content("Application #{app_3.id}")
    expect(page).to have_content("Application #{app_4.id}")

  end
end
