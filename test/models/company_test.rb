require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  test "Validate correct companies" do
    # Compañía 1 debe ser válida con los atributos correctos
    company_1 = companies(:company_1)
    assert company_1.valid?
    company_2 = companies(:company_2)
    assert company_2.valid?
    company_3 = companies(:company_3)
    assert company_3.valid?
  end

  test "Validate that name is required and unique" do
    # Compañía sin nombre debe ser inválida
    company = Company.new
    assert_not company.valid?
    assert_includes company.errors.full_messages, "Name can't be blank"

    # Compañía con nombre duplicado debe ser inválida
    company_duplicate = Company.new(name: "Nintendo")
    assert_not company_duplicate.valid?
    assert_includes company_duplicate.errors.full_messages, "Name has already been taken"
  end
end
