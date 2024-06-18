<?php
namespace DataWarehouse\Visualization;

/*
 * @author Joe White
 * @author Jeanette Sperhac
 *
 * Class that governs color selection for plotting datasets in chart classes.
 * Adapted for use with configure() method. Lookup is by index; round robin only.
 * Todo: resuscitate fixed mapping, which is constructed to work with dataset names.
 *
 */

class ColorGenerator
{
    // If the number of datasets is below the threhold, then the mapping
    // is a fixed map of dataset name -> dataset color. If the number of 
    // datasets is above the threshold, then a simple first-come first-served 
    // mapping is used. 
    const COLOR_MAP_THRESHOLD = 64;

    private $colors = array();
    private $color_idx;
    private $limit_color;
    private $mode;

    // ---------------------------------------------------------
    // @param configColor, hexdec color value from the colors array.
    // create the colors array, setting current index as user selected color for dataset.
    // backward compatible to Usage tab, for now.
    //
    //public function __construct( $configColor=null )
    // ---------------------------------------------------------
    public function __construct($datanamevalues=null, 
                                $limit=null, 
                                $useShortNames=null,
                                $configColor=null ) 
    {
        $this->limit_color = $this::COLOR_MAP_THRESHOLD;

        $this->build_roundrobinmapping();

        // if configColor is null, color idx is 0
        $this->setConfigColor( $configColor );
    }

    // ---------------------------------------------------------
    // getConfigColor() 
    // 
    // Assign configColor and return it.
    //
    // if user has selected a starting color for the dataseries, 
    // set it as the initial color for the plot.
    // ---------------------------------------------------------
    public function getConfigColor( $configColor ) 
    {
        $this->setConfigColor( $configColor );
        return $this->getColorByIdx( $this->color_idx );
    }

    // ---------------------------------------------------------
    // setConfigColor() 
    //
    // if user has selected a starting color for the dataseries, 
    // set it as the initial color for the plot.
    // ---------------------------------------------------------
    public function setConfigColor( $configColor ) 
    {
        // if configColor is null, color idx is 0
        if (is_null($configColor)) 
        {
            $this->color_idx = 0;

        } else {
            // If configColor found in colors array, set that as current idx.
            $si = array_search( $configColor, $this->colors);
            $this->color_idx = ($si > -1) 
                                ? $si 
                                : 0; // default 0
        }
        //return $this->color_idx;
    }

    // ---------------------------------------------------------
    // getColorByIdx()
    //
    // Specify color_idx; look up and return resulting color from
    // colors array.
    // ---------------------------------------------------------
    private function getColorByIdx( $idx )
    {
        if ($this->mode == "ROUND_ROBIN") {
            $color = $this->colors[ $idx % count($this->colors) ];
            $this->color_idx = ++$idx;
            return $color;
        } elseif (isset($this->colors[$idx])) {
            // fixed mapping
            return $this->colors[$idx];
        } else 
        {
            return $this->limit_color;
        }
    }

    // ---------------------------------------------------------
    // build_roundrobinmapping()
    //
    // color_idx is set in constructor based on user selection
    // ---------------------------------------------------------
    private function build_roundrobinmapping()
    {
        $this->mode = "ROUND_ROBIN";
        $this->colors = \DataWarehouse\Visualization::getColors(NULL, 0, false);
    }

    // ---------------------------------------------------------
    // getColor()
    //
    // Fetch and return current color; increment color index.
    //
    // @param string
    // default null returns current color for round robin mapping
    // ---------------------------------------------------------
    public function getColor( $dataseriesname = NULL )
    {
        if ($this->mode == "ROUND_ROBIN" || is_null($dataseriesname)) {
            $color = $this->colors[ $this->color_idx % count($this->colors) ];
            $this->color_idx += 1;
            return $color;
        } elseif (isset($this->colors[$dataseriesname])) {
            return $this->colors[$dataseriesname];
        } else 
        {
            return $this->limit_color;
        }
    }
} // class ColorGenerator
