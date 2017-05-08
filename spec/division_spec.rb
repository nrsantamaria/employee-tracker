require('spec_helper')

describe(Division) do
  it("tells which employees are in it") do
    division = Division.create({:name => 'name'})
    employee1 = Employee.create({:first_name => 'Nicole',:last_name => 'Santamaria',:division_id => division.id})
    employee2 = Employee.create({:first_name => 'Sowmya', :last_name => 'Dinavahi',:division_id => division.id})
    expect(division.employees()).to(eq([employee1, employee2]))
  end
end
