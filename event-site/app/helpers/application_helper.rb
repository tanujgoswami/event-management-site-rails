module ApplicationHelper

  def tag_cloud(tags, classes)
    max_tag = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count / max_tag.count * (classes.count - 1)
      yield(tag, classes[index.round])
    end
  end

end
