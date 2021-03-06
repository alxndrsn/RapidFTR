module EnquiriesHelper
  module View
    PER_PAGE = 20
    MAX_PER_PAGE = 9999
  end

  ORDER_BY = {'active' => 'created_at', 'all' => 'created_at'}
end

def number_of_enquiries_with_matches
  Enquiry.all.all.select { |enquiry| enquiry.potential_matches.size > 0 }.size
end
