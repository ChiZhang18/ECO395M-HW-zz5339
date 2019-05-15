The Streams Analysis of Pop Music in 2018
=========================================

By Chong Wang, Tianping Wu, Zhenning Zhao, Zhiyang Lin

Introduction
------------

Popular music market is extremely large, especially in recent years. Pop songs inspire generations from all walks of life. Every day, oceans of pop tracks jump on to the Top 200 List of Spotify. In this project, we analysed the data of the 2018 popular music database from Spotify.com, in order to help the big digital music server improve playlist song recommendations and to help the record companies make decisions on which album to promote according to the predictions on the playing streams.

This project mainly answers the following questions: first, predict the streams of the tracks; and second, analysis the pattern of the popularity trend. To answer the first question, we used stepwise method, the lasso method and the random forest and boosting to build a prediction model of the streams of the tracks, with the features of the songs and the albums as predictor. In order to answer the second question, we first used PCA and K-means to cluster the songs by features, dividing songs into different categories. Then we plotted the trend of the popularity of different type of songs, showing the change in the trend of the listener’s taste.

Data
----

The dataset that we use comes from spotify.com. Spotify is one of the biggest digital music servicer that gives you access to many songs. From <https://spotifycharts.com>, we have the weekly data of the top 200 songs in the US. We use the data of 2018, giving us 1,497 different songs.

Fortunately, Spotify has a public API, which provides us many useful features of the songs. We use python robot to gather the data of not only the song features but also the data of the artists and the album. In the end, the formal dataset includes the following variables:

Table1: Variable Descriptions

<table style="width:56%;">
<colgroup>
<col width="23%" />
<col width="31%" />
</colgroup>
<thead>
<tr class="header">
<th>variables</th>
<th>descriptions</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>id</td>
<td>song ID</td>
</tr>
<tr class="even">
<td>duration_ms_x</td>
<td>The duration of the track in milliseconds.</td>
</tr>
<tr class="odd">
<td>acousticness</td>
<td>A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic.</td>
</tr>
<tr class="even">
<td>danceability</td>
<td>Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable.</td>
</tr>
<tr class="odd">
<td>energy</td>
<td>Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale. Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy.</td>
</tr>
<tr class="even">
<td>instrumentalness</td>
<td>Predicts whether a track contains no vocals. “Ooh” and “aah” sounds are treated as instrumental in this context. Rap or spoken word tracks are clearly “vocal”. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0.</td>
</tr>
<tr class="odd">
<td>liveness</td>
<td>Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live.</td>
</tr>
<tr class="even">
<td>loudness</td>
<td>The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful for comparing relative loudness of tracks. Loudness is the quality of a sound that is the primary psychological correlate of physical strength (amplitude). Values typical range between -60 and 0 db.</td>
</tr>
<tr class="odd">
<td>mode</td>
<td>Mode indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. Major is represented by 1 and minor is 0.</td>
</tr>
<tr class="even">
<td>speechiness</td>
<td>Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words. Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music. Values below 0.33 most likely represent music and other non-speech-like tracks.</td>
</tr>
<tr class="odd">
<td>tempo</td>
<td>The overall estimated tempo of a track in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration.</td>
</tr>
<tr class="even">
<td>valence</td>
<td>A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry).</td>
</tr>
<tr class="odd">
<td>key</td>
<td>The estimated overall key of the track. Integers map to pitches using standard Pitch Class notation . E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on. If no key was detected, the value is -1.</td>
</tr>
<tr class="even">
<td>time_signature</td>
<td>An estimated overall time signature of a track. The time signature (meter) is a notational convention to specify how many beats are in each bar (or measure).</td>
</tr>
<tr class="odd">
<td>relseaseDuration</td>
<td>The date the album was first released.</td>
</tr>
</tbody>
</table>

The explanation of the variables comes from the following link: <https://developer.spotify.com/documentation/web-api/reference/tracks/get-audio-analysis/> Although this project only run on the dataset of 2018, we can do similar analysis for spotify for more songs and more recent data with similar method.

    ## Streams ~ danceability + speechiness + explicitTRUE + key8

    ## Streams ~ duration_ms_x + acousticness + danceability + energy + 
    ##     liveness + loudness + mode + speechiness + valence + key6 + 
    ##     key8 + key10 + explicitTRUE + relseaseDuration + explicitTRUE:relseaseDuration + 
    ##     valence:explicitTRUE + duration_ms_x:key8 + energy:liveness + 
    ##     acousticness:liveness + mode:speechiness + mode:key10 + speechiness:explicitTRUE + 
    ##     liveness:key6 + acousticness:energy + valence:key6 + mode:key6 + 
    ##     danceability:key8 + key8:explicitTRUE + valence:key8 + speechiness:key8

![](final_project_files/figure-markdown_github/pathplot3-1.png)

    ## Streams ~ danceability + speechiness + key8 + explicitTRUE + 
    ##     relseaseDuration

![](final_project_files/figure-markdown_github/pathplot4-1.png)

    ## Streams ~ danceability + danceability:time_signature4 + danceability:explicitTRUE + 
    ##     energy:speechiness + speechiness:relseaseDuration + key8:explicitTRUE + 
    ##     time_signature4:explicitTRUE

    ## Distribution not specified, assuming gaussian ...

    ## Distribution not specified, assuming gaussian ...
    ## Distribution not specified, assuming gaussian ...
    ## Distribution not specified, assuming gaussian ...
    ## Distribution not specified, assuming gaussian ...
    ## Distribution not specified, assuming gaussian ...
    ## Distribution not specified, assuming gaussian ...
    ## Distribution not specified, assuming gaussian ...
    ## Distribution not specified, assuming gaussian ...
    ## Distribution not specified, assuming gaussian ...
    ## Distribution not specified, assuming gaussian ...

    ## [1] 34861269 34583941 34849850 34820011 34618342 34914735

|                               |  coefficients.Estimate|  coefficients.Std..Error|  coefficients.t.value|  coefficients.Pr...t..|
|-------------------------------|----------------------:|------------------------:|---------------------:|----------------------:|
| (Intercept)                   |           1.140462e+07|             1.451707e+07|             0.7856007|              0.4322428|
| duration\_ms\_x               |          -2.302173e+01|             2.060254e+01|            -1.1174219|              0.2640178|
| acousticness                  |           4.443487e+06|             1.358047e+07|             0.3271969|              0.7435710|
| danceability                  |           2.404583e+07|             8.182758e+06|             2.9385973|              0.0033544|
| energy                        |           6.793030e+06|             1.422992e+07|             0.4773767|              0.6331731|
| liveness                      |           1.496744e+08|             3.930043e+07|             3.8084674|              0.0001463|
| loudness                      |           1.181442e+06|             6.012029e+05|             1.9651304|              0.0496091|
| mode                          |           6.088800e+06|             3.053952e+06|             1.9937446|              0.0463859|
| speechiness                   |           2.154659e+07|             1.780755e+07|             1.2099690|              0.2265079|
| valence                       |          -2.187674e+07|             7.722874e+06|            -2.8327203|              0.0046857|
| key6                          |           2.892070e+06|             1.113720e+07|             0.2596765|              0.7951539|
| key8                          |          -2.342799e+07|             2.361419e+07|            -0.9921151|              0.3213236|
| key10                         |          -5.988868e+06|             4.280707e+06|            -1.3990372|              0.1620373|
| explicitTRUE                  |          -1.135980e+08|             3.007322e+07|            -3.7773811|              0.0001656|
| relseaseDuration              |          -1.962746e+00|             3.425947e+02|            -0.0057291|              0.9954298|
| explicitTRUE:relseaseDuration |           1.468476e+04|             3.904863e+03|             3.7606331|              0.0001769|
| valence:explicitTRUE          |           2.451811e+07|             9.206285e+06|             2.6631926|              0.0078347|
| duration\_ms\_x:key8          |           1.624178e+02|             7.129942e+01|             2.2779685|              0.0228881|
| energy:liveness               |          -1.902833e+08|             5.196448e+07|            -3.6617947|              0.0002604|
| acousticness:liveness         |          -1.338086e+08|             3.846141e+07|            -3.4790356|              0.0005196|
| mode:speechiness              |          -2.584703e+07|             1.445181e+07|            -1.7884978|              0.0739255|
| mode:key10                    |           7.638239e+06|             6.888008e+06|             1.1089185|              0.2676678|
| speechiness:explicitTRUE      |          -4.126666e+07|             1.870125e+07|            -2.2066260|              0.0275122|
| liveness:key6                 |           6.680831e+07|             3.080819e+07|             2.1685246|              0.0302973|
| acousticness:energy           |           3.767796e+07|             2.233166e+07|             1.6871993|              0.0918018|
| valence:key6                  |          -3.243932e+07|             1.936793e+07|            -1.6748986|              0.0941915|
| mode:key6                     |           1.352786e+07|             8.023182e+06|             1.6860971|              0.0920140|
| danceability:key8             |          -5.022478e+07|             2.383914e+07|            -2.1068201|              0.0353219|
| key8:explicitTRUE             |           2.632320e+07|             9.186314e+06|             2.8654799|              0.0042299|
| valence:key8                  |           4.048841e+07|             1.606122e+07|             2.5208805|              0.0118235|
| speechiness:key8              |          -2.803594e+07|             2.610494e+07|            -1.0739704|              0.2830327|

![](final_project_files/figure-markdown_github/pdp-1.png)

PCA and Clustering
------------------

### General methodologies

We would like to segment the 1,497 songs into groups with similar features in order to recommend to listeners who share the same interests/taste. For the reason of reducing unnecessary noises and computations, we first reduced the initial 27 variables by PCA. Next, we clustered them into groups with similar principle components, and based on the features in each principal component and the actual songs in each cluster, we were able to describe them in secular terminologies such as “genre”.

### PCA

We would like to use PCA to balance between the amount of computation load and explanatory variability, while eliminating as much noise as possible from our data. After centering and scaling of the data, we calculated the the loading matrix/scores matrix in order to derive the proportion of variance explained (PVE) and decide the number of principal components needed.

| ID   | Standard deviation  | Proportion of Variance | Cumulative Proportion |
|:-----|:--------------------|:-----------------------|:----------------------|
| PC1  | 2.80212353537273    | 0.112084941414909      | 0.1121                |
| PC2  | 1.77344288190906    | 0.0709377152763623     | 0.183                 |
| PC3  | 1.46727876624167    | 0.058691150649667      | 0.2417                |
| PC4  | 1.44279628131763    | 0.0577118512527051     | 0.2994                |
| PC5  | 1.2024934848242     | 0.0480997393929679     | 0.3475                |
| PC6  | 1.18118422033003    | 0.0472473688132011     | 0.3948                |
| PC7  | 1.16471426274806    | 0.0465885705099224     | 0.4414                |
| PC8  | 1.11901808461181    | 0.0447607233844724     | 0.4861                |
| PC9  | 1.10874235654547    | 0.0443496942618188     | 0.5305                |
| PC10 | 1.08797663277924    | 0.0435190653111695     | 0.574                 |
| PC11 | 1.08178043639889    | 0.0432712174559556     | 0.6173                |
| PC12 | 1.06412510961753    | 0.0425650043847012     | 0.6598                |
| PC13 | 1.05315275540945    | 0.0421261102163779     | 0.702                 |
| PC14 | 1.03932598862547    | 0.0415730395450188     | 0.7435                |
| PC15 | 1.00612785222318    | 0.0402451140889271     | 0.7838                |
| PC16 | 0.947189585246249   | 0.03788758340985       | 0.8217                |
| PC17 | 0.892958210859255   | 0.0357183284343702     | 0.8574                |
| PC18 | 0.821043647001771   | 0.0328417458800708     | 0.8902                |
| PC19 | 0.756342698063931   | 0.0302537079225572     | 0.9205                |
| PC20 | 0.647404260335455   | 0.0258961704134182     | 0.9464                |
| PC21 | 0.604914885182242   | 0.0241965954072897     | 0.9706                |
| PC22 | 0.419178980270296   | 0.0167671592108118     | 0.9873                |
| PC23 | 0.209254918185628   | 0.00837019672742513    | 0.9957                |
| PC24 | 0.100442731001129   | 0.00401770924004517    | 0.9997                |
| PC25 | 0.00698743489964209 | 0.000279497395985684   | 1                     |

In the table above, we see that the first 20 principle components explain more than 90% of the variability. We believe that these 20 principle components would keep our computation load low and eliminate some of the noises, while keeping the majority of the variability. Clustering would further group our songs based on these 20 principle components.

### Clustering

K-means++ clustering was used to determine our market segments. 3 types of supporting analysis were used to help us determine the the number of them(centroids): Elbow plot(SSE), CH index and Gap statistics.

![](final_project_files/figure-markdown_github/K-grid-1.png)

![](final_project_files/figure-markdown_github/CH-grid-1.png)

![](final_project_files/figure-markdown_github/Gap-1.png)

As shown above, both elbow plot and CH index returned K=16 and gap statistics K=4. Clustering 16 segments would not show us distinct differences among them as we now only have 20 principle components to allocate. So we selected K=4 as our anchor and explored the nearby Ks to see which one provides us the best explanation for each cluster. By “best explanation”, we considered the following 2 categories.

-   Clusters that have songs with clear and unique distribution in any of the 20 features.
-   Clusters that have songs with clear genre by their artist name and actual music.(we played a considerable quantity of sample size from each cluster on Youtube to confirm this)

As the result, we eventually picked K = 5.

Song market segments breakdown by distribution of features After the 5 clusters are determined, we reversed the principle components into the original features to determine cluster characteristics. We show some of the cluster identifiable distributions and the summary of each cluster below.

![](final_project_files/figure-markdown_github/PC1-1.png)

![](final_project_files/figure-markdown_github/PC2-1.png)

![](final_project_files/figure-markdown_github/PC3-1.png)

Cluster 1: High in energy, high in loudness, high danceability, low speechiness, considerate amount of G key, low acousticness

Cluster 2: Many 5 quarter time signature songs, high in energy

Cluster 3: Many songs with high energy, high on loudness

Cluster 4: Many songs with high on loudness, high danceability, considerable amount of B flat key

Cluster 5: Many 3 quarter time signature songs, low speechiness

### Song market segments breakdown by genre

Since we have the full list of song names and artist names available in each cluster, we could actually listen to the songs and categorize them manually by the music genre standard as in pop, rock, rap, etc. If our cluster characteristics determined by K-means++ show close resemblance of the music genre, then our recommendation system may be effective, at least to the extent of traditional music listeners with distinct preference over specific genre.

Cluster 1: Many songs with electronically altered/amplified sounds, very rhythmic, but genre varying from pop to rap to country, etc. Typical examples would be I Get The Bag by Gucci Mane, Echame La Culpa by Luis Fonsi, IDGAF by Dua Lipa.

Cluster 2: Indeed many songs with 5/4 time signature, high energy and rhythmic, but clearly sets apart different vibe compared cluster 1, perhaps due to the different time signature. Typical examples would be Top Off by DJ Khaled, You Can Cry by Marshmello, and Creep on me by GASHI.

Cluster 3: Genre varies a lot in this cluster, as shown in the very different artists such as Drake, Kendrick Lamar, Taylor Swift, XXXTENTACION and Queen. We did realize that out of the many rap songs in this cluster, most of them were the “slower” ones. For example, Wow by Post Malone and Forever Ever by Trippie Redd.

Cluster 4: Songs in B flat key stands out, such as Betrayed by Lil Xan and Midnight Summer Jam by Justin Timberlake, which make this cluster a different vibe than others.

Cluster 5: Many indie and pop songs with long vowel sounds, typical examples would be A Million Dreams by Ziv Zaifman, Perfect by Ed Sheeran and The Night We met by Lord Huron.

### Trend in popularity

We also calculated the total streams of different song clusters by time. The following graph shows the trend in the total streams of different categories.

From this graph we can see that the stream of five types of songs doesn’t change too much in a year. Cluster 1 music has more streams overall, due to the fact that there are more songs in this categories. There is a peak in the end of April in 2018 for cluster 1, and then the streams goes back to normal. From this graph we can also see that at the end of the year cluster 1 music is not as popular as in the middle of the year, but type 3 music becomes more and more popular, especially in july and the end of the year. The popularity of cluster 2, cluster 4 and cluster 5 music doesn’t change too much in the whole year.

![](final_project_files/figure-markdown_github/trend-1.png)

Conclusion
----------

Traditionally music listeners explore songs by specific genre and artists. This confirmation bias, typically nurtured through years of artificial genre segmentation by media and artist reputation, could be limiting listeners from the songs that they really want to exposed to. The question of “Why are we attracted to certain songs?” is a philosophical discussion that is beyond the scope of our project here, but given the data from spotify data and our clustering method, we perhaps show that key, time signature and speed of the songs are some of the contributing factors to our inner biological working of what to like and dislike. Then, our basic recommendation system, most likely already used by music industry like Spotify, could recommend songs not by mere genre and artist names, but also by specific keys and time signatures each listener is attracted to, subconsciously.