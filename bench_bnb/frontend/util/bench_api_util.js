export const fetchBenches = function(success) {
  $.ajax({
    method: 'GET',
    url: '/api/benches',
    success,
    error: () => console.log('error')
  });
};
