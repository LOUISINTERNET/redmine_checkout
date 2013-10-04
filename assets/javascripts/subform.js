var Subform = function(rawHTML, lineIndex, parentElement) { this.init(rawHTML, lineIndex, parentElement); }

// $.extend(Subform.protype, {
Subform.prototype = {
  lineIndex: 1,
  parentElement: "",
  init: function(rawHTML, lineIndex, parentElement) {
    this.rawHTML        = rawHTML;
    this.lineIndex      = lineIndex;
    this.parentElement  = "#" + parentElement;
  },
  
  parsedHTML: function() {
    return this.rawHTML.replace(/--INDEX--/g, this.lineIndex++);
  },
  
  add: function() {
    $(this.parsedHTML()).appendTo(this.parentElement);
    $(this.parentElement).children().last().slideToggle();
    recalculate_even_odd(this.parentElement);
  },
  
  add_after: function(e) {
    $(this.parsedHTML()).insertAfter(e);
    $(e).next().slideToggle();
    recalculate_even_odd(this.parentElement);
  },
  
  add_on_top: function() {
    $(this.parsedHTML()).prependTo(this.parentElement);
    $(this.parentElement).children().first().slideToggle();
    recalculate_even_odd(this.parentElement);
  }
};

function recalculate_even_odd(element) {
  $(element).children().each(function(index) {
      $(this).removeClass("even");
      $(this).removeClass("odd");
      $(this).addClass( (index%2==0) ? "odd" : "even");
    }
  )
}
