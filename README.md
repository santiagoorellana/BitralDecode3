BitralDecode (Demodulation Processor):

Introduction:
When a signal is demodulated by software, the final result can be a chain of symbols that carries within it the transmitted message, usually encrypted, and other data necessary for synchronization and error correction. When you know the encoding and protocol used by the sender and receiver, it is easy to know where the message is and what to do to retrieve it; but not so when the signal is unknown. Through the analysis of the signal, it is possible to know the type of modulation that is used and correctly demodulates the signal, but it is necessary to carry out a study of its structure. The BitralDecode tool facilitates the analysis and processing of the string of symbols resulting from the demodulation.

Brief description of the tool:
BitralDecode is an MDI application that allows the user to work with several demodulations at the same time. The tools it uses are implemented as separate threads, thus allowing the user to continue working with the application while the tool is running.

The application allows the user among other things:
- View the demodulation raster in both color and grayscale.
- Edit the demodulation through graphical interaction with the raster.
- Automatically search for possible periods of demodulation, as well as any other type of cyclic structure.
- Find the occurrences of a string within the demodulation.
- Point to files in a given folder that contain at least one occurrence of a specific string.
- Compare two demodulations and view the result graphically, thus revealing the structures common to both.

Loading and editing a demodulation.
By means of a simple dialog, the user is allowed to select the file that contains the string of characters resulting from the demodulation. Once the file is loaded, the program automatically searches for the periodic repetitions of substrings that occur within the demodulation. At the end of the search, the user is presented with a list of the periodic repetitions found and a color matrix of the demodulation data. We will call this matrix the demodulation raster and it can also be shown in gray scale.

Simply select one of the periods from the list so that the demodulation raster is displayed with that period. By finding the correct period, the raster reveals some interesting structures of the demodulated signal. The same can be done with demodulations of more than two symbols.

If the user wishes to edit the demodulations, he only has to activate the Text Editor or Raster Editor tab. Immediately the raster will be displayed in edit mode. Once the editing mode is activated, the user will be able to make use of the editing methods of the window toolbar. You can among other things:

- Select lines or blocks.
- Clear the selection.
- Cut the selection.
- Copy the selection.
- Fill the selection with a given value.
- Paste a copied or cut selection at a given position.
- Insert data serially at a given point of the raster.
- Filter to remove characters that do not belong to the set of allowed symbols.

If the user makes mistakes, you can undo the changes in order as they were made. When you are satisfied with the edit, you can save the changes to the original file or to a new one.

Automatic period search.
For the advanced search of the periodic repetitions of the demodulation, a tool that implements some pattern detection algorithms can be used. Once the recurrences are detected, they are displayed in a list, ordered according to their importance.

Comparison of demodulations.
Other tools provided by the application are comparators. These are used to compare two demodulations, thus revealing their differences or common structures.

The Diff Comparator uses an algorithm widely used in the analysis of DNA strands and other complex proteins. It uses dynamic programming concepts so it is very efficient in speed and classifies the differences according to a mathematical model of the types of possible errors (Deletions, Insertions, Replacements).

Another comparator is the Most, created by the authors, which looks for the greatest similarities between two demodulations. The mathematical error model used by this comparator is different from that of the Diff comparator and is closer to our needs.

Both comparators show their results through graphs that allow observing the similarity structures between the compared demodulations.

Search for strings.
We also have a chain search tool. This looks for the occurrence of a given string in all demodulation files contained in the given folder.

Upcoming developments
The BitralDecode application in its version 4 will try to solve other more complex problems related to decoding and error correction.
In addition, other internal structure comparison and disclosure tools will be included, as well as facilities to map the demodulations by sections, insert comments, marks and finally facilitate the semi-automatic creation of reports.

Designer and programmer: Santago A. Orellana Pérez
Email: tecnochago@gmail.com
Mobile: +53 54635944
Havana, Cuba, 2012






