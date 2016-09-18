import React from 'react';


class PokemonDetail extends React.Component {

  render() {
    const {attack, defense, id, image_url, name, poke_type, moves, toys} = this.props.displayPokemon;
    let allToys, allMoves;
    if (toys) {
      allToys = toys.map((toy) => {
        // debugger
        return (
          <img src={toy.image_url} />
        );
      });
    }

    if (moves) {
      allMoves = moves.map(move => {
        return (<li>{move}</li>);
      });
    }

    return (
      <section className="pokemon-detail">
        <ul>
          <img src={image_url} />
          <li><h2>{name}</h2></li>
          <li>Type: {poke_type}</li>
          <li>Attack: {attack}</li>
          <li>Defense: {defense}</li>
          <li>Moves: &#34;{allMoves}&#34;</li>
          <section className="toys">
            <h3>Toys</h3>
            <ul className="toy-list">
              {allToys}
            </ul>
          </section>
        </ul>
      </section>
    );
  }
}

export default PokemonDetail;
