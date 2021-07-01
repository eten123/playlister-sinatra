require 'rack-flash'

class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash
    get "/songs" do 
        @songs = Song.all
        erb :"songs/index"
    end 

    get "/songs/new" do
        @genres=Genre.all
        erb :"songs/new"
    end

    patch "/songs" do
        song = Song.find(params[:id])

        artist = Artist.find_by(name: params[:artist][:name])
        if (artist == nil)
            artist = Artist.create(params[:artist])
        end

        params[:song][:artist_id] = artist.id
        song.update(params[:song])

        SongGenre.where(song_id: song.id).destroy_all()

        if (params[:genres] != nil)
            params[:genres].each{ |genre| SongGenre.create(song_id: song.id, genre_id: genre[:id]) }
        end
        flash[:message] = "Successfully updated song."

        redirect "/songs/#{song.slug}"
    end

    get "/songs/:slug/edit" do
        @song=Song.find_by_slug(params[:slug])
        @genres=Genre.all
        erb :"songs/edit"
    end

    get "/songs/:slug" do
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/show"
    end

    post "/songs" do
        artist = Artist.find_by(name: params[:artist][:name])
        if (artist == nil)
            artist = Artist.create(params[:artist])
        end

        params[:song][:artist_id] = artist.id
        song = Song.create(params[:song])
        if (params[:genres] != nil)
            params[:genres].each{ |genre| SongGenre.create(song_id: song.id, genre_id: genre[:id]) }
        end
        flash[:message] = "Successfully created song."

        redirect "/songs/#{song.slug}"
    end


end