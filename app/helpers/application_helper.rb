module ApplicationHelper
  def render_explanation_with_images(question)
    return "" if question.explanation.blank?

    text = question.explanation.dup
    images = question.explanation_images.to_a
    used_indices = []

    # Replace [fotoN] tags (1-indexed for users: [foto1], [foto2]...)
    text.gsub!(/\[foto(\d+)\]/i) do |match|
      index = $1.to_i - 1
      if images[index]
        used_indices << index
        render_explanation_image(images[index])
      else
        match # Keep the tag if no image found at that index
      end
    end

    # Also render any images that were NOT used in the text at bottom
    remaining_images = images.reject.with_index { |_, i| used_indices.include?(i) }
    
    output = simple_format(text)
    
    if remaining_images.any?
      gallery = content_tag(:div, class: "explanation-gallery", style: "margin-top: 1.5rem; display: flex; flex-direction: column; gap: 1.5rem;") do
        remaining_images.map { |img| render_explanation_image(img) }.join.html_safe
      end
      output += gallery
    end

    output
  end

  private

  def render_explanation_image(img)
    content_tag(:div, style: "text-align: center; margin: 1rem 0;") do
      image_tag img, 
                class: "img-explanation", 
                data: { action: "click->exam-session-v2#enlarge" }, 
                style: "cursor: pointer; transition: transform 0.2s;"
    end
  end
end
