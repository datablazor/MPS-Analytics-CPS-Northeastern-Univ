#!/usr/bin/env python

from __future__ import print_function

from flask import Flask, request, Response
import json
import pymysql

app = Flask(__name__)

@app.route("/", methods=['GET'])
def artist_albums():
    connection = pymysql.connect(host='localhost',
                                 user='root',
                                 password='',
                                 db='Chinook',
                                 cursorclass=pymysql.cursors.DictCursor)
    
    with connection.cursor() as cursor:    
        if 'artist_name' in request.args:
            sql = 'SELECT art.Name AS art_name, alb.Title AS alb_title FROM artist art INNER JOIN album alb ON art.ArtistId=alb.ArtistId WHERE art.Name LIKE %s ORDER BY art_name ASC, alb_title ASC'
            params = tuple([request.args['artist_name']])
        else:
            sql = 'SELECT art.Name AS art_name, alb.Title AS alb_title FROM album alb INNER JOIN artist art ON alb.ArtistId=art.ArtistId ORDER BY art_name ASC, alb_title ASC'
            params = tuple([])
            
        cursor.execute(sql, params)        
        
        resp = Response(json.dumps([{"artist":row['art_name'], "album":row['alb_title']} for row in cursor.fetchall()]), status=200, mimetype='application/json')
        
        # for local testing only
        resp.headers['Access-Control-Allow-Origin'] = '*'
        
        return resp

@app.errorhandler(404)
def page_not_found(e):
    return Response(json.dumps({'msg': 'route not found'}), status=404, mimetype='application/json')

if __name__ == '__main__':
    app.run()
