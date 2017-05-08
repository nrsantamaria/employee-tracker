require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('./lib/division')
require('./lib/employee')
require('./lib/project')
also_reload('lib/**/*.rb')
require('pg')

get('/') do
  @divisions = Division.all
  erb(:index)
end

post('/divisions') do
  name = params.fetch('name')
  division = Division.new({:name => name})
  division.save
  erb(:success)
end

get('/divisions/:id') do
  @division = Division.find(params.fetch('id').to_i())
  @employees = Employee.all
  erb(:division)
end

get('/divisions/:id/edit') do
  @division = Division.find(params.fetch('id').to_i())
  erb(:division_edit)
end

patch('/divisions/:id') do
  name = params.fetch('name')
  @division = Division.find(params.fetch('id').to_i())
  @division.update({:name => name})
  @divisions = Division.all
  erb(:index)
end

delete('/divisions/:id') do
  @division = Division.find(params.fetch('id').to_i())
  @division.delete
  @divisions = Division.all
  erb(:index)
end

post('/employees') do
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  division_id = params.fetch('division_id').to_i()
  @division = Division.find(division_id)
  @employee = Employee.new({:first_name => first_name, :last_name => last_name, :division_id => division_id})
  @employee.save
  erb(:success)
end

get('/employees/:id') do
  @employee = Employee.find(params.fetch("id").to_i())
  @division = Division.find(@employee.division_id)
  @divisions = Division.all()
  erb(:division)
end

get('/employees/:id/edit') do
  @employee = Employee.find(params.fetch("id").to_i())
  @division = Division.find(@employee.division_id)
  erb(:employee_edit)
end

patch('/employees/:id') do
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  division_id = params.fetch('division_id')
  @division = Division.find(division_id)
  @employee = Employee.find(params.fetch('id').to_i())
  @employee.update({:first_name => first_name, :last_name => last_name, :division_id => division_id})
  @employees = Employee.all
  erb(:division)
end

delete('/employees/:id') do
  @employee = Employee.find(params.fetch('id').to_i())
  @division = Division.find(@employee.division_id)
  @employee.delete
  @employees = Employee.all
  erb(:division)
end
