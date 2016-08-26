export const fetchAllPokemon = (success) => {

  $.ajax({
    type: 'GET',
    url: '/api/pokemon',
    dataType: "json",
    success
  });
};

export const fetchSinglePokemon = (pokemonId, success) => {
  $.ajax({
    type: 'GET',
    url: `/api/pokemon/${pokemonId}`,
    dataType: "json",
    success
  });
};

//
// export const receiveAllPokemon = (allPokemon) => (
//   console.log(allPokemon)
// );
