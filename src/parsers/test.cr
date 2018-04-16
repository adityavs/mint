class Parser
  syntax_error TestExpectedOpeningBracket
  syntax_error TestExpectedClosingBracket
  syntax_error TestExpectedExpression
  syntax_error TestExpectedName

  def test : Ast::Test | Nil
    start do |start_position|
      skip unless keyword "test"

      whitespace
      name = string_literal! TestExpectedName
      whitespace

      expression = block(
        opening_bracket: TestExpectedOpeningBracket,
        closing_bracket: TestExpectedClosingBracket
      ) do
        expression! TestExpectedExpression
      end

      Ast::Test.new(
        expression: expression,
        from: start_position,
        to: position,
        input: data,
        name: name)
    end
  end
end