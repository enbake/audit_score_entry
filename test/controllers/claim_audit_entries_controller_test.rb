require 'test_helper'

class ClaimAuditEntriesControllerTest < ActionController::TestCase
  setup do
    @claim_audit_entry = claim_audit_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:claim_audit_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create claim_audit_entry" do
    assert_difference('ClaimAuditEntry.count') do
      post :create, claim_audit_entry: { admin_score: @claim_audit_entry.admin_score, claim: @claim_audit_entry.claim, compliance_score: @claim_audit_entry.compliance_score, estimating_score: @claim_audit_entry.estimating_score, estimator: @claim_audit_entry.estimator, leakage_amount: @claim_audit_entry.leakage_amount, overall_score: @claim_audit_entry.overall_score, review: @claim_audit_entry.review, reviewer: @claim_audit_entry.reviewer }
    end

    assert_redirected_to claim_audit_entry_path(assigns(:claim_audit_entry))
  end

  test "should show claim_audit_entry" do
    get :show, id: @claim_audit_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @claim_audit_entry
    assert_response :success
  end

  test "should update claim_audit_entry" do
    patch :update, id: @claim_audit_entry, claim_audit_entry: { admin_score: @claim_audit_entry.admin_score, claim: @claim_audit_entry.claim, compliance_score: @claim_audit_entry.compliance_score, estimating_score: @claim_audit_entry.estimating_score, estimator: @claim_audit_entry.estimator, leakage_amount: @claim_audit_entry.leakage_amount, overall_score: @claim_audit_entry.overall_score, review: @claim_audit_entry.review, reviewer: @claim_audit_entry.reviewer }
    assert_redirected_to claim_audit_entry_path(assigns(:claim_audit_entry))
  end

  test "should destroy claim_audit_entry" do
    assert_difference('ClaimAuditEntry.count', -1) do
      delete :destroy, id: @claim_audit_entry
    end

    assert_redirected_to claim_audit_entries_path
  end
end
