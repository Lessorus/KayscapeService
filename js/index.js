
// дропдаун (не забыть потом допилить css часть)

const profileMenu = document.querySelector('.profile-menu')
const profileDropdown = document.getElementById('profile-dropdown')

profileMenu.addEventListener('click', function() {
  const isOpen = profileDropdown.style.display === 'block'

  if (isOpen) {
    profileDropdown.style.display = 'none'
  } else {
    profileDropdown.style.display = 'block'
  }
})

document.addEventListener('click', function(e) {
  if (!profileMenu.contains(e.target) && !profileDropdown.contains(e.target)) {
    profileDropdown.style.display = 'none'
  }
})


//НЕ ЗАБЫТ ДОДЕЛАТЬ ТУТ И ВСЁ ЧТО НИЖЕ

const wishlistBtns = document.querySelectorAll('.wishlist-btn')

wishlistBtns.forEach(function(btn) {
  btn.addEventListener('click', function() {
    const svg = btn.querySelector('svg')
    const isActive = btn.getAttribute('aria-pressed') === 'true'

    if (isActive) {
      btn.setAttribute('aria-pressed', 'false')
      svg.style.fill = 'rgba(0, 0, 0, 0.5)'
    } else {
      btn.setAttribute('aria-pressed', 'true')
      svg.style.fill = '#ff385c'
    }
  })
})

//  ТАБЫ ДЕЛАТЬ 

const tabLinks = document.querySelectorAll('.tab-link')

tabLinks.forEach(function(tab) {
  tab.addEventListener('click', function() {
    tabLinks.forEach(function(t) {
      t.classList.remove('active')
      t.setAttribute('aria-selected', 'false')
    })

    tab.classList.add('active')
    tab.setAttribute('aria-selected', 'true')
  })
})

//ПОКАЗАТЬ БОЛЬШЕ И ДРУГОЕ ТАМ

const showMoreBtn = document.querySelector('.show-more')

if (showMoreBtn) {
  const locationItems = document.querySelectorAll('.location-item')
  const visibleCount = 12

  locationItems.forEach(function(item, index) {
    if (index >= visibleCount && !item.querySelector('.show-more')) {
      item.style.display = 'none'
    }
  })

  let isExpanded = false

  showMoreBtn.addEventListener('click', function() {
    if (isExpanded) {
      locationItems.forEach(function(item, index) {
        if (index >= visibleCount && !item.querySelector('.show-more')) {
          item.style.display = 'none'
        }
      })
      showMoreBtn.textContent = 'Показать больше ∨'
      isExpanded = false
    } else {
      locationItems.forEach(function(item) {
        item.style.display = ''
      })
      showMoreBtn.textContent = 'Скрыть ∧'
      isExpanded = true
    }
  })
}

//  НАВИГАЦИЯ и ниже)))

const navLinks = document.querySelectorAll('.nav-links a')

navLinks.forEach(function(link) {
  link.addEventListener('click', function() {
    navLinks.forEach(function(l) {
      l.classList.remove('active')
    })
    link.classList.add('active')
  })
})

