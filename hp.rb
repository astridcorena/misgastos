require 'httparty'

HTTParty.post('http://localhost:3000/api/v1/expenses', headers: {'Content-Type'=> 'application/json'}, body: {type_id: 2,category_id: 6, concept: "Concepto de Prueba", date: "2018-03-31", amount: 550000}.to_json)
