class Supports::CategorySupport
  attr_reader :category

  def initialize args
    @category = args[:category]
  end

  def languages
    @languages ||= Language.all.collect do |language|
      [language.name, language.id]
    end
  end
end
