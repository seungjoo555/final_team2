function dropdownReset(dropdown, placeholderText) {
  dropdown.addClass("placeholder");
  dropdown.find("> input").val("");
  dropdown.find("> button").text(placeholderText);
  dropdown.find(".dropdown-list button").removeClass("selected");
};

function dropdownRerender(dropdown, placeholderText, list) {
  dropdown.addClass("placeholder");
  dropdown.removeClass("open error-row");
  dropdown.find("> input").val("");
  dropdown.find("> button").text(placeholderText);
  dropdown.find(".dropdown-list button").removeClass("selected");
  dropdown.find(".dropdown-list li").remove();

  let listHtml;

  for (var i = 0; i < list.length; i++) {
    listHtml += `
    <li>
      <button type="button" data-value="${list[i].value ? list[i].value : "list[i].value"}">
        ${list[i].label ? list[i].label : "list[i].label"}
      </button>
    </li>
    `;
  }

  dropdown.find(".dropdown-list ul").html(listHtml);
}

$(function() {
  $(document).on("click", ".dropdown-box > button", function(e) {
    const box = $(this).closest(".dropdown-box"),
          list = box.find(".dropdown-list");

    if ($(".dropdown-box.open").not(box).length > 0) {
      $(".dropdown-box.open").not(box).find(".dropdown-list").slideUp();
      $(".dropdown-box.open").not(box).removeClass("open");
    }

    list.slideToggle();
    box.toggleClass("open");
  });

  $(document).on("click", ".dropdown-list button", function(e) {
    const row = $(this).closest(".input-row"),
          box = $(this).closest(".dropdown-box"),
          list = box.find(".dropdown-list"),
          label = $(this).text(),
          value = $(this).attr("data-value");

    if (box.hasClass("placeholder")) box.removeClass("placeholder");

    box.find("> input").val(value).trigger("change");
    box.find("> button").text(label);

    list.find("button").removeClass("selected");
    $(this).addClass("selected");

    row.removeClass("error-row");
    list.slideUp();
    box.removeClass("open");
  });

  $(window).keyup(function(e) {
    if (e.key === "Escape") {
      if ($(".dropdown-box.open").length > 0) {
        e.stopImmediatePropagation();

        $(".dropdown-box.open .dropdown-list").slideUp();
        $(".dropdown-box.open").removeClass("open");
      }
    }
  });

  $(document).click(function(e) {
    if (!$(e.target).hasClass(".dropdown-box") && $(e.target).closest(".dropdown-box").length == 0) {
      $(".dropdown-box .dropdown-list").slideUp();
      $(".dropdown-box").removeClass("open");
    }
  });
});