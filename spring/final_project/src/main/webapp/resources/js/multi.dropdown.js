function hideResetMultiDropdown(selector) {
  selector.find(".dropdown-list").slideUp();
  selector.removeClass("open");

  setTimeout(function() {
    selector.find(".list-search input").val("");
    selector.find(".dropdown-list li").show();
    selector.find(".dropdown-list li.empty").remove();
    selector.find(".dropdown-list li p").each(function() {
      $(this).text($(this).text());
    })
  }, 400);
}

function MultiDropdownRerender(selector, list) {
  selector.addClass("placeholder");
  selector.removeClass("open error-row");
  selector.find("> button").text(selector.find("> button").data("placeholder"));
  selector.find("> input").val("");
  selector.find(".list-search input").val("");
  selector.find(".dropdown-list li").remove();
  selector.find(".dropdown-list").hide();

  let listHtml;

  for (var i = 0; i < list.length; i++) {
    listHtml += `
    <li>
      <label>
        <input type="checkbox"
          class="multi-dropdown-item"
          value="${list[i].value ? list[i].value : "list[i].value"}" 
        />
        <p>${list[i].label ? list[i].label : "list[i].label"}</p>
      </label>
    </li>
    `;
  }

  selector.find(".dropdown-list ul").html(listHtml);
}

$(function() {
  $(document).on("click", ".multi-dropdown-box > button", function(e) {
    const box = $(this).closest(".multi-dropdown-box"),
          list = box.find(".dropdown-list");

    if ($(".multi-dropdown-box.open").not(box).length > 0) {
      hideResetMultiDropdown($(".multi-dropdown-box.open").not(box));
    }

    if (box.attr("direction") == "top") {
      list.find("ul").after(list.find(".list-search"));
    } else {
      list.find("ul").before(list.find(".list-search"));
    }

    list.slideToggle();
    box.toggleClass("open");
  });

  $(document).on("keydown", ".multi-dropdown-box .list-search input", function(e) {
    if (e.keyCode === 13) {
      e.preventDefault();
    }
  });

  $(document).on("keyup", ".multi-dropdown-box .list-search input", function(e) {
    const box = $(this).closest(".multi-dropdown-box"),
          list = box.find(".dropdown-list li"),
          keyword = $(this).val(),
          regex = new RegExp(keyword, "gi");

    list.not(".empty").each(function() {
      const $text = $(this).find("p"),
            match = $text.text().match(regex) !== null;

      if (match) {
        $text.html($text.text().replace(regex, "<span>$&</span>"));

        $(this).show();
      } else {
        $(this).hide();
      } 
    })

    if (list.not(".empty").filter(":visible").length == 0) {
      if (list.filter(".empty").length == 0) {
        box.find(".dropdown-list ul").append("<li class='empty'>검색 결과가 없습니다.</li>");
      }
    } else {
      list.filter(".empty").remove();
    } 
  });

  $(document).on("change", ".multi-dropdown-item", function() {
    const row = $(this).closest(".input-row"),
          box = $(this).closest(".multi-dropdown-box"),
          checkValues = [];

    box.find(".multi-dropdown-item:checked").each(function() {
      checkValues.push({
        label:$(this).next("p").text(),
        value:$(this).val()
      });
    });
    
    if (checkValues.length === 0) {
      box.addClass("placeholder");
      box.find("> button").text(box.find("> button").data("placeholder"));
    } else {
      row.removeClass("error-row");
      box.removeClass("placeholder");
      box.find("> button").text(checkValues.map(item => item.label).join(", "));
    }

    box.find("> input").val(checkValues.map(item => item.value).join(",")).trigger("change");
  });

  $(window).keyup(function(e) {
    if (e.key === "Escape") {
      if ($(".multi-dropdown-box.open").length > 0) {
        e.stopImmediatePropagation();

        hideResetMultiDropdown($(".multi-dropdown-box"));
      }
    }
  });

  $(document).click(function(e) {
    if (!$(e.target).hasClass(".multi-dropdown-box") && $(e.target).closest(".multi-dropdown-box").length == 0) {
      hideResetMultiDropdown($(".multi-dropdown-box"));
    }
  });
});