import React from 'react';
import { TONES, NOTE_NAMES } from '../../util/tones.js';
import Note from '../../util/note.js';
import $ from 'jquery';
import NoteKey from './note_key';

const KEYS_TO_NOTE_NAMES = {
  65: 'C5',
  83: 'D5',
  68: 'E5',
  70: 'F5',
  71: 'G5',
  72: 'A5',
  74: 'B5',
  75: 'C6'
};

class Synth extends React.Component {
  constructor(props) {
    super(props);
    this.notes = NOTE_NAMES.map( name => new Note(TONES[name]));
    this.playNotes = this.playNotes.bind(this);
  }

  onKeyDown (e) {
    let key = KEYS_TO_NOTE_NAMES[e.which];
    this.props.keyPressed(key);
  }

  onKeyUp (e) {
    let key = KEYS_TO_NOTE_NAMES[e.which];
    this.props.keyReleased(key);
  }

  playNotes () {
    let synth = this;

    this.notes.forEach((note, index) => {
      if(synth.props.notes.includes(NOTE_NAMES[index])){
        note.start();
      } else {
        note.stop();
      }
    });
  }

  componentDidMount() {
    $(document).on('keydown', e => this.onKeyDown(e));
    $(document).on('keyup', e => this.onKeyUp(e));
  }

  render(){
    this.playNotes();
    let synth = this;

    const notes = this.notes.map((note, index) => {
      let active =
        (synth.props.notes.includes(NOTE_NAMES[index])) ?
        "active notekey" :
        "notekey";
      return (<NoteKey
        className={active}
        key={index}
        notename={NOTE_NAMES[index]}
      />);
    });

    return (
      <div>
        {notes}
      </div>
    );
  }
}

export default Synth;
