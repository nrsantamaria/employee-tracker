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

get('/employees') do
  @employees = Employee.all
  erb(:employees)
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

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post('/projects') do
  name = params.fetch("project_name")
  project = Project.new({:name => name, :id => nil})
  project.save
  erb(:success)
end

get('/project') do
  @project = Project.find(params.fetch('id').to_i())
  @employees = Employee.all
  erb(:project)
end

get('/projects/:id') do
  @project = Project.find(params.fetch('id').to_i())
  @employees = Employee.all
  erb(:project)
end

patch('/projects/:id') do
  project_id = params.fetch('id').to_i()
  @project = Project.find(project_id)
  employee_ids = params.fetch('employee_ids')
  @project.update({:employee_ids => employee_ids})
  @employees = Employee.all
  erb(:project)
end

get('/projects/:id/edit') do
  @project = Project.find(params.fetch('id').to_i())
  erb(:project_edit)
end


delete('/projects/:id') do
  @project = Project.find(params.fetch('id').to_i())
  @project.delete
  @projects = Project.all
  erb(:index)
end

post('/employees') do
  first_name = params.fetch('first_name')
  last_name = params.fetch('last_name')
  project_id = params.fetch('project_id').to_i()
  @project = Project.find(project_id)
  @employee = Employee.new({:first_name => first_name, :last_name => last_name, :project_id => project_id})
  @employee.save
  erb(:success)
end
