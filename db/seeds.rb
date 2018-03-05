# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    # response = Wknd::ApiResponse.new(
    #   "Friday", # Jour aller
    #   "Sunday", # Jour retour
    #   {from: "18%3A00",to: "23%3A59"}, # Range heures aller
    #   {from: "18%3A00",to: "23%3A59"}, # Range heures retour
    #   "PAR", # From
    #   "MAD")

    #   go_date = response.date_of_next(response.go_day)
    #   return_date = response.date_of_next(response.return_day)
    #   if go_date > return_date
    #     return_date = return_date + 7
    #   end
    # p response.call
    render_to_string 'shared/weekendcard'

