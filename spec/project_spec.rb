require('spec_helper')

describe(Project) do
    it("tells which project are you in") do
      project = Project.create({:name => 'name'})
      employee1 = Employee.create({:first_name => 'Nicole',:last_name => 'Santamaria',:project_id => project.id})
      employee2 = Employee.create({:first_name => 'Sowmya', :last_name => 'Dinavahi',:project_id => project.id})
      expect(project.employees()).to(eq([employee1, employee2]))
    end
  end
end
