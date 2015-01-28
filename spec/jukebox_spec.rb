require 'pry'
require_relative 'spec_helper'

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

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

  context "with commands" do
    it "responds to 'help'" do
      expect { help }.to output(/^(?=.*help)(?=.*list)(?=.*play)(?=.*exit).+/m).to_stdout
    end

    it "responds to 'list'" do
      expect { list(songs) }.to output(/Phoenix - 1901/).to_stdout
    end

    context "the 'play' method accepts 'songs' as an argument" do
      it "can use a number to find a song" do
        allow(self).to receive(:gets).and_return("1")
        expect { play(songs) }.to output(/Phoenix - 1901/).to_stdout
      end

      it "can use a full song name to find a song" do
        allow(self).to receive(:gets).and_return("Phoenix - 1901")
        expect{ play(songs) }.to output(/Phoenix - 1901/).to_stdout
      end

      it 'checks for invalid number input' do
        allow(self).to receive(:gets).and_return("12323")
        expect { play(songs) }.to output(/Invalid input, please try again/).to_stdout
      end
    end


    it "responds to 'exit'" do
      expect { exit_jukebox }.to output(/Goodbye/).to_stdout
    end
  end

  it "should start the script with the run method" do
    allow(self).to receive(:gets).and_return("exit")
    expect { run(songs) }.to output(/Please enter a command:/).to_stdout
  end
end
