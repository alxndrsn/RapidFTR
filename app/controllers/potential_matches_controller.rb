class PotentialMatchesController < ApplicationController
  before_action :authorize_update
  before_action :load_potential_match

  def destroy
    @potential_match.mark_as_invalid
    @potential_match.save
    flash[:notice] = t('enquiry.messages.child_record_marked_as_not_a_match_successfully')
    redirect_to url_for :controller => :enquiries, :action => :show, :id => @potential_match.enquiry_id, :anchor => 'tab_potential_matches'
  end

  def update
    if params[:confirmed]
      @potential_match.confirmed = params[:confirmed]
      @potential_match.save
    end
    redirect_to url_for :controller => :enquiries, :action => :show, :id => @potential_match.enquiry_id, :anchor => 'tab_potential_matches'
  end

  private

  def load_potential_match
    enquiry_id = params.delete(:enquiry_id)
    child_id = params.delete(:id)
    @potential_match = PotentialMatch.by_enquiry_id_and_child_id.key([enquiry_id, child_id]).all.first
  end

  def authorize_update
    authorize! :update, Enquiry
  end
end
