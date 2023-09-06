require 'rails_helper'

RSpec.describe "Application Show Page" do
  describe "As a user" do
    describe "when I visit /applications/:id" do
      it "Shows all applicant info" do
        dude = Applicant.create(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
        state: "Texas", zip_code: "75248", description: "I love animals!")
        shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        pet_1 = shelter.pets.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
        application = PetsApplication.create!(applicant: dude, pet: pet_1)

        visit "/pets_applications/#{application.id}"

        within('.applicant_information') do
        expect(find('h1')).to have_content("James")
        expect(page).to have_content("11234 Jane Street")
        expect(page).to have_content("Dallas")
        expect(page).to have_content("Texas")
        expect(page).to have_content("75248")
        expect(page).to have_content("I love animals!")
        expect(page).to have_content("In Progress")
        expect(page).not_to have_content("Add a Pet to this Application")
        end
      end
    end

    it "should allow a visitor to search for and add a pet to their application" do
      dude = Applicant.create(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
      state: "Texas", zip_code: "75248", description: "I love animals!")
      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter.pets.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
      pet_2 = shelter.pets.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe")
      application = PetsApplication.create!(applicant: dude)

      visit "/pets_applications/#{application.id}"
      
      within('.search') do
        fill_in('search', with: "Lucille Bald")
        click_button("Search")
        expect(page).to have_current_path("/pets_applications/#{application.id}?search=Lucille+Bald&commit=Search")
      end
      
      within('.searched_pets_submit') do 
        expect(page).to have_content("Lucille Bald")
        click_button("Adopt this pet?")
        expect(page).to have_current_path("/pets_applications/#{application.id}")
        expect(page).to have_content("Lucille Bald")
      end
      
      within('.search') do
        fill_in('search', with: "Babe")
        click_button("Search")
      end

      within('.searched_pets_submit') do
        expect(page).to have_current_path("/pets_applications/#{application.id}?search=Babe&commit=Search")
        expect(page).to have_content("Babe")
        click_button("Adopt this pet?")
        expect(page).to have_current_path("/pets_applications/#{application.id}")
        expect(page).to have_content("Lucille Bald")
        expect(page).to have_link(href: "/pets/#{pet_1.id}")
        expect(page).to have_link(href: "/pets/#{pet_2.id}")
      end
    end

    it "should allow a visitor to submit an application with added pets" do
      dude = Applicant.create(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
      state: "Texas", zip_code: "75248", description: "I love animals!")
      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter.pets.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
      pet_2 = shelter.pets.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe")
      application = PetsApplication.create!(applicant: dude)

      visit "/pets_applications/#{application.id}"
      
      within('.search') do
        fill_in('search', with: "Lucille Bald")
        click_button("Search")
        expect(page).to have_current_path("/pets_applications/#{application.id}?search=Lucille+Bald&commit=Search")
      end
      
      within('.searched_pets_submit') do 
        expect(page).to have_content("Lucille Bald")
        click_button("Adopt this pet?")
        expect(page).to have_current_path("/pets_applications/#{application.id}")
        expect(page).to have_content("Lucille Bald")
      end
      
      within('.search') do
        fill_in('search', with: "Babe")
        click_button("Search")
      end

      within('.searched_pets_submit') do
        expect(page).to have_current_path("/pets_applications/#{application.id}?search=Babe&commit=Search")
        expect(page).to have_content("Babe")
        click_button("Adopt this pet?")
        expect(page).to have_current_path("/pets_applications/#{application.id}")
        expect(page).to have_content("Lucille Bald")
        expect(page).to have_link(href: "/pets/#{pet_1.id}")
        expect(page).to have_link(href: "/pets/#{pet_2.id}")
        click_button("Submit Application")
      end

      within('.applicant_information') do
        expect(page).to have_content("Pending")
      end
    end
  

    it "I see links to all pets on this application" do
      dude = Applicant.create(name: "James", street_address: "11234 Jane Street", city: "Dallas", 
      state: "Texas", zip_code: "75248", description: "I love animals!")
      shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
      pet_1 = shelter.pets.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald")
      pet_2 = shelter.pets.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe")
      application = PetsApplication.create!(applicant: dude, pet: pet_1)
      PetsApplication.create!(applicant: dude, pet: pet_2)

      visit "/pets_applications/#{application.id}"

      within('.searched_pets_submit') do
        expect(page).to have_link(href: "/pets/#{pet_1.id}")
        expect(page).to have_link(href: "/pets/#{pet_2.id}")
      end
    end
  end
end