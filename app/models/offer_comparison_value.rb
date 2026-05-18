class OfferComparisonValue
  attr_reader :label

  def self.yes(label = "✓")
    new(label:, state: :yes)
  end

  def self.no(label = "–")
    new(label:, state: :no)
  end

  def self.text(label)
    new(label:, state: :text)
  end

  def initialize(label:, state:)
    @label = label
    @state = state
  end

  def yes?
    @state == :yes
  end

  def no?
    @state == :no
  end
end
