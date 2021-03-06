BHM.withNS('Admin.Questions', function(ns) {
  var sortable;
  ns.reorderQuestionsURL = '/admin/questions/reorder';
  ns.dialogSelector = '#reorder-questions';
  ns.sortableSelector = 'ul';
  ns.linkSelector = '.reorder-questions-link';
  sortable = false;
  ns.showReorderDialog = function() {
    ns.makeSortable();
    return $(ns.dialogSelector).dialog();
  };
  ns.makeSortable = function() {
    if (sortable) {
      return null;
    }
    $(("" + (ns.dialogSelector) + " " + (ns.sortableSelector))).sortable();
    return (sortable = true);
  };
  ns.bindReorderButton = function() {
    return $(ns.linkSelector).click(function() {
      ns.showReorderDialog();
      return false;
    });
  };
  return (ns.setup = function() {
    return ns.bindReorderButton();
  });
});