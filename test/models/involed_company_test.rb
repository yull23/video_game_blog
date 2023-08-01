require "test_helper"

class InvoledCompanyTest < ActiveSupport::TestCase
  def setup
    @company_1 = companies(:company_1)
    @game_1 = games(:game_1)
  end
  test "Validate correct field 'developer' and 'publisher'" do
    involed_company_1 = involed_companies(:involed_company_1)
    assert involed_company_1.valid?
    assert_not_nil involed_company_1.developer
    assert_not_nil involed_company_1.publisher

    involed_company_2 = involed_companies(:involed_company_2)
    assert involed_company_2.valid?
    assert_not_nil involed_company_2.developer
    assert_not_nil involed_company_2.publisher

    involed_company_3 = involed_companies(:involed_company_3)
    assert involed_company_3.valid?
    assert_not_nil involed_company_3.developer
    assert_not_nil involed_company_3.publisher
  end

  test "Validate correct references with company and games" do
    # skip
    involed_company_4 = InvoledCompany.create(
      company: companies(:company_1),
      game: games(:game_6),
      developer: true,
      publisher: true
    )
    involed_company_duplicate = involed_company_4.dup
    assert_not involed_company_duplicate.save
    assert_includes involed_company_duplicate.errors.full_messages,
                    "Company should be a unique combination"
  end

  test "Validate relation belongs_to: company and game" do
    # skip
    assert_equal @game_1.involed_companies.count, 2
    assert_equal @company_1.involed_companies.count, 2
  end
  test "VValidate has_many relationship between games and companies" do
    assert_equal @company_1.games.count, 2
    assert_equal @game_1.companies.count, 2
  end
end
