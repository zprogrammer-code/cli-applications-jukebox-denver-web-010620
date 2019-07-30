require_relative 'spec_helper'

songs = [
  "Phoenix - 1901",
  "Tokyo Police Club - Wait Up",
  "Sufjan Stevens - Too Much",
  "The Naked and the Famous - Young Blood",
  "(Far From) Home - Tiga",
  "The Cults - Abducted",
  "Phoenix - Consolation Prizes",
  "Harry Chapman - Cats in the Cradle",
  "Amos Lee - Keep It Loose, Keep It Tight"
]

describe "CLI Jukebox" do

  context "methods" do
    describe "#help" do
      it "lists out the possible commands" do
        expect( $stdout ).to receive(:puts).with(/I accept the following commands:/)
        expect( $stdout ).to receive(:puts).with(/- help : displays this help message/)
        expect( $stdout ).to receive(:puts).with(/- list : displays a list of songs you can play/)
        expect( $stdout ).to receive(:puts).with(/- play : lets you choose a song to play/)
        expect( $stdout ).to receive(:puts).with(/- exit : exits this program/)
        help
      end
    end

    describe '#play' do
      it "can find a song when given a number from the user" do
        allow(self).to receive(:gets).and_return("1")
        expect( $stdout ).to receive(:puts).with(/Please enter a song name or number:/)
        expect( $stdout ).to receive(:puts).with(/Phoenix - 1901/)
        expect( $stdout ).to_not receive(:puts).with(/Tokyo Police Club - Wait Up/)
        play(songs)
      end

      it "can find a song when given a full song name" do
        allow(self).to receive(:gets).and_return("Phoenix - 1901")
        expect( $stdout ).to receive(:puts).with(/Please enter a song name or number:/)
        expect( $stdout ).to receive(:puts).with(/Phoenix - 1901/)
        play(songs)
      end

      it 'returns an error when given a number that does not correspond to a song' do
        allow(self).to receive(:gets).and_return("12323")
        expect( $stdout ).to receive(:puts).with(/Please enter a song name or number:/)
        expect( $stdout ).to receive(:puts).with(/Invalid input, please try again/)
        play(songs)
      end

      it 'returns an error when given a name that does not correspond to an existing song' do
        allow(self).to receive(:gets).and_return("Blah blah foo blah")
        expect( $stdout ).to receive(:puts).with(/Please enter a song name or number:/)
        expect( $stdout ).to receive(:puts).with(/Invalid input, please try again/)
        play(songs)
      end
    end

    describe "#list" do
      it "lists out the available songs" do
        expect( $stdout ).to receive(:puts).with(/1. Phoenix - 1901/)
        expect( $stdout ).to receive(:puts).with(/2. Tokyo Police Club - Wait Up/)
        expect( $stdout ).to receive(:puts).with(/3. Sufjan Stevens - Too Much/)
        expect( $stdout ).to receive(:puts).with(/4. The Naked and the Famous - Young Blood/)
        expect( $stdout ).to receive(:puts).with(/5. \(Far From\) Home - Tiga/)
        expect( $stdout ).to receive(:puts).with(/6. The Cults - Abducted/)
        expect( $stdout ).to receive(:puts).with(/7. Phoenix - Consolation Prizes/)
        expect( $stdout ).to receive(:puts).with(/8. Harry Chapman - Cats in the Cradle/)
        expect( $stdout ).to receive(:puts).with(/9. Amos Lee - Keep It Loose, Keep It Tight/)
        list(songs)
      end
    end

    describe "#exit_jukebox" do
      it "terminates the running of the program and outputs 'Goodbye'" do
        expect( $stdout ).to receive(:puts).with(/Goodbye/)
        exit_jukebox
      end
    end
  end

  context "with commands" do
    it "responds to 'exit'" do
      expect($stdout).to receive(:puts).with(/Please enter a command:/)
      expect($stdout).to receive(:puts).with(/Goodbye/)
      allow(self).to receive(:gets).and_return("exit")
      run(songs)
    end

    it "responds to 'help'" do
      allow(self).to receive(:gets).and_return("help", "exit")
      expect{ run(songs) }.to output(/Please enter a command:/).to_stdout
      allow(self).to receive(:gets).and_return("help", "exit")
      expect{ run(songs) }.to output(/I accept the following commands:/).to_stdout
      allow(self).to receive(:gets).and_return("help", "exit")
      expect{ run(songs) }.to output(/- help : displays this help message/).to_stdout
      allow(self).to receive(:gets).and_return("help", "exit")
      expect{ run(songs) }.to output(/- list : displays a list of songs you can play/).to_stdout
      allow(self).to receive(:gets).and_return("help", "exit")
      expect{ run(songs) }.to output(/- play : lets you choose a song to play/).to_stdout
      allow(self).to receive(:gets).and_return("help", "exit")
      expect{ run(songs) }.to output(/- exit : exits this program/).to_stdout

    end

    it "responds to 'list'" do
      allow(self).to receive(:gets).and_return("list", "exit")
      expect{ run(songs) }.to output(/Please enter a command:/).to_stdout
      allow(self).to receive(:gets).and_return("list", "exit")
      expect{ run(songs) }.to output(/1. Phoenix - 1901/).to_stdout
      allow(self).to receive(:gets).and_return("list", "exit")
      expect{ run(songs) }.to output(/9. Amos Lee - Keep It Loose, Keep It Tight/).to_stdout
      
    end

    it "responds to 'play'" do
      allow(self).to receive(:gets).and_return("play", "1", "exit")
      expect{ run(songs) }.to output(/Please enter a command:/).to_stdout
      allow(self).to receive(:gets).and_return("play", "1", "exit")
      expect{ run(songs) }.to output(/Please enter a song name or number:/).to_stdout
      allow(self).to receive(:gets).and_return("play", "1", "exit")
      expect{ run(songs) }.to output(/Playing Phoenix - 1901/).to_stdout
    end

  end

end
