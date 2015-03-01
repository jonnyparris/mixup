feature "Finished circles" do
  before do
    @j_dilla = create(:user)
    login_as(@j_dilla)
    @new_beat1 = create(:track, creator: @j_dilla, track_name: "HippityHop")
    @past_circle = create(:past_circle)
    create(:stem_submit, circle: @past_circle, original: @new_beat1)
    create_list(:stem_submit, 5, circle: @past_circle)
    @past_circle.mixup
    @past_circle.members.each do |member|
      allocated_stem = member.allocated_stem(@past_circle.id)
      remix = create(:track, creator: member)
      submission = @past_circle.submissions.find_by(original: allocated_stem)
      submission.update_attributes(remix: remix)
    end
    visit circle_path(@past_circle)
  end

  scenario "should have all stems and remixes" do
    remix = @past_circle.submissions.find_by(original: @new_beat1).remix
    expect(page).to have_content(@new_beat1.track_name)
    expect(page).to have_content(remix.track_name)
  end
end
