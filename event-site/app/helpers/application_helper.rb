module ApplicationHelper

  def tag_cloud(tags, classes)
    max_tag = tags.sort_by(&:length).last
    tags.each do |tag|
      index = tag.length / max_tag.length * (classes.length - 1)
      yield(tag, classes[index.round])
    end
  end

end
