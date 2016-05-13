class EventSearchTerm
  attr_reader :where_clause, :where_args, :order

  def initialize(search_term)
    search_term = search_term.downcase.strip
    @where_clause = ""
    @where_args = {}
    if search_term =~ /@/
      build_for_email_search(search_term)
    else
      build_for_title_search(search_term)
    end
  end

  def build_for_email_search(search_term)
    @where_clause << case_insensitive_search(:email)
    @where_args[:email] = search_term
    @order = "email asc"
  end

  def build_for_title_search(search_term)
    @where_clause << case_insensitive_search(:title)
    @where_args[:title] = starts_with(search_term)
    @order = "title asc"
  end

  def starts_with(search_term)
    search_term + "%"
  end

  def case_insensitive_search(field_name)
    "lower(#{field_name}) like :#{field_name}"
  end
end
