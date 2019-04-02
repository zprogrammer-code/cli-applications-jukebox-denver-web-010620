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
        expect { help }.to output(/^(?=.*help)(?=.*list)(?=.*play)(?=.*exit).+/m).to_stdout
      end
    end

    describe '#play' do
      it "can find a song when given a number from the user" do
        allow(self).to receive(:gets).and_return("1")
        expect { play(songs) }.to output(/Phoenix - 1901/).to_stdout
      end

      it "can find a song when given a full song name" do
        allow(self).to receive(:gets).and_return("Phoenix - 1901")
        expect{ play(songs) }.to output(/Phoenix - 1901/).to_stdout
      end

      it 'returns an error when given a number that does not correspond to a song' do
        allow(self).to receive(:gets).and_return("12323")
        expect { play(songs) }.to output(/Invalid input, please try again/).to_stdout
      end

      it 'returns an error when given a name that does not correspond to an existing song' do
        allow(self).to receive(:gets).and_return("Blah blah foo blah")
        expect { play(songs) }.to output(/Invalid input, please try again/).to_stdout
      end
    end

    describe "#list" do
      it "lists out the available songs" do
        expect { list(songs) }.to output(/1. Phoenix - 1901/).to_stdout
        expect { list(songs) }.to output(/2. Tokyo Police Club - Wait Up/).to_stdout
        expect { list(songs) }.to output(/3. Sufjan Stevens - Too Much/).to_stdout
        expect { list(songs) }.to output(/4. The Naked and the Famous - Young Blood/).to_stdout
        expect { list(songs) }.to output(/5. \(Far From\) Home - Tiga/).to_stdout
        expect { list(songs) }.to output(/6. The Cults - Abducted/).to_stdout
        expect { list(songs) }.to output(/7. Phoenix - Consolation Prizes/).to_stdout
        expect { list(songs) }.to output(/8. Harry Chapman - Cats in the Cradle/).to_stdout
        expect { list(songs) }.to output(/9. Amos Lee - Keep It Loose, Keep It Tight/).to_stdout
      end
    end

    describe "#exit_jukebox" do
      it "terminates the running of the program and outputs 'Goodbye'" do
        expect { exit_jukebox }.to output(/Goodbye/).to_stdout
      end
    end
  end

  context "with commands" do
    it "responds to 'exit'" do
      allow(self).to receive(:gets).and_return("exit")
      exit_output = capture_stdout { run(songs) }
      expect(exit_output).to include("Please enter a command:").and include("Goodbye")
    end

    it "responds to 'help'" do
      allow(self).to receive(:gets).and_return("help", "exit")
      help_output = capture_stdout { run(songs) }
      expect(help_output).to include("help").and include("list").and include("play").and include("exit").and include("Please enter a command:").and include("Goodbye")

    end

    it "responds to 'list'" do
      allow(self).to receive(:gets).and_return("list", "exit")
      list_output = capture_stdout { run(songs) }
      expect(list_output).to include("Please enter a command:").and include("1. Phoenix - 1901").and include("9. Amos Lee - Keep It Loose, Keep It Tight")
    end

    it "responds to 'play'" do
      allow(self).to receive(:gets).and_return("play", "1", "exit")
      list_output = capture_stdout { run(songs) }
      expect(list_output).to include("Please enter a command:").and include("Please enter a song name or number:").and include("Playing Phoenix - 1901")
    end

  end

end
