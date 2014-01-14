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
      output = capture_stdout {help}
      output.should match(/help|play|exit|list/)
    end
 
    it "responds to 'list'" do
      output = capture_stdout { list(songs) }
      output.should match(/Phoenix - 1901/)
    end
 
    # stub! is deprecated but the test doesnt work with
    # stub
    it "responds to 'play' and accepts a number as an argument" do
      stub!(:gets).and_return("1")
      output = capture_stdout { play(songs) }
      output.should match(/Phoenix - 1901/)
    end

    it "responds to 'play' and accepts a full song name as an argument" do
      stub!(:gets).and_return("Phoenix - 1901")
      output = capture_stdout { play(songs) }
      output.should match(/Phoenix - 1901/)
    end

    it "responds to 'exit'" do
      output = capture_stdout { exit }
      output.should match(/Goodbye/)
    end
  end
 
  it "should start the script with the run method" do
    stub!(:gets).and_return("exit")
    output = capture_stdout { run }
    output.should match(/Please enter a command:/)
  end
end