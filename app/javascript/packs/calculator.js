import datepickerFactory from 'jquery-datepicker';
datepickerFactory($);

$(document).on('turbolinks:load', () => {
  $('.disbursement-date').datepicker()
  $('.calculator-form').on('ajax:success', (e) => {
    $('.result').html(e.detail[2].responseText)
    $('.message').html('')
  })

  $('.calculator-form').on('ajax:error', (e) => {
    $('.message').html(e.detail[0].messages.join("<br \>"))
  })
})