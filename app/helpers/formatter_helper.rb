module FormatterHelper
  def string_formatter string, options = {}
    string
  end

  def number_formatter number, options = {}
    sign = '+' if options[:include_sign] and quantity > 0
    placeholder = options[:placeholder] || 'N/A'
    precision = options[:precision] || 2
    strip_insignificant_zeros = options[:strip_insignificant_zeros] || true
    delimiter = options[:delimiter] || ','
    number.blank? ? placeholder : "#{sign}#{number_with_precision(number, precision: precision, strip_insignificant_zeros: strip_insignificant_zeros, delimiter: delimiter)}" 
  end

  def boolean_formatter boolean, options = {}
    if boolean
      'Yes'
    else
      'No'
    end
  end

  def date_formatter date, options = {}
    date.try(:strftime, '%Y-%m-%d')
  end

  def time_formatter time, options = {}
    time.try(:strftime, '%H:%M')
  end

  def datetime_formatter datetime, options = {}
    datetime.try(:strftime, '%Y-%m-%d %H:%M')
  end

  def styled_flash
    dismiss_btn = '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'
    if flash[:alert]
      raw "<div class=\"alert alert-danger alert-icon-block alert-dismissible\"><div class=\"alert-icon\"><span class=\"icon-warning\"></span></div>#{dismiss_btn}#{flash[:alert]}</div>"
    elsif flash[:notice]
      raw "<div class=\"alert alert-success alert-icon-block alert-dismissible\"><div class=\"alert-icon\"><span class=\"icon-checkmark-circle\"></span></div>#{dismiss_btn}#{flash[:notice]}</div>"
    end
  end
end