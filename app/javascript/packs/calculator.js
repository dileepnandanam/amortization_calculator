$(document).on('turbolinks:load', () => {
  $('.calculator-form').on('ajax:success', (e) => {
    $('.result').html(e.detail[2].responseText)
  })

  $('.calculator-form').on('ajax:error', (e) => {
    $('.message').html(e.detail[0].message)
  })
})